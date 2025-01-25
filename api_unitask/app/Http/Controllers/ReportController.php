<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    /**
     * Display a listing of the reports.
     */
    public function index()
    {
        $reports = Report::with(['building', 'room', 'category', 'creator'])
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json(['data' => $reports], 200);
    }

    /**
     * Store a newly created report in storage.
     */
    public function store(Request $request)
    {
        // Validate incoming request
        $validated = $request->validate([
            'building_id' => 'required|string|max:10',
            'room_id' => 'required|string|max:10',
            'category_id' => 'required|integer|exists:categories,category_id',
            'priority' => 'required|in:Immediate,Normal',
            'description' => 'required|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048', // Optional image upload
        ]);

        // Generate unique folio
        do {
            $folio = str_pad(rand(0, 9999999), 7, '0', STR_PAD_LEFT);
        } while (Report::where('folio', $folio)->exists());

        // Create the report
        $report = Report::create([
            'folio' => $folio,
            'building_id' => $validated['building_id'],
            'room_id' => $validated['room_id'],
            'category_id' => $validated['category_id'],
            'priority' => $validated['priority'],
            'description' => $validated['description'],
            'image' => $request->file('image') ? $request->file('image')->store('reports', 'public') : null,
            'created_by' => auth()->id(), // Assuming the user is authenticated
            'status' => 'Pending',
        ]);

        return response()->json(['message' => 'Report created successfully!', 'data' => $report], 201);
    }

    /**
     * Display the specified report.
     */
    public function show($folio)
    {
        $report = Report::with(['building', 'room', 'category', 'creator'])->where('folio', $folio)->first();

        if (!$report) {
            return response()->json(['message' => 'Report not found'], 404);
        }

        return response()->json(['data' => $report], 200);
    }

    /**
     * Update the specified report in storage.
     */
    public function update(Request $request, $folio)
    {
        $report = Report::where('folio', $folio)->first();

        if (!$report) {
            return response()->json(['message' => 'Report not found'], 404);
        }

        // Validate incoming request
        $validated = $request->validate([
            'building_id' => 'nullable|string|max:10',
            'room_id' => 'nullable|string|max:10',
            'category_id' => 'nullable|integer|exists:categories,category_id',
            'priority' => 'nullable|in:Immediate,Normal',
            'description' => 'nullable|string',
            'status' => 'nullable|in:Pending,In Progress,Completed',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        // Update report fields
        $report->update([
            'building_id' => $validated['building_id'] ?? $report->building_id,
            'room_id' => $validated['room_id'] ?? $report->room_id,
            'category_id' => $validated['category_id'] ?? $report->category_id,
            'priority' => $validated['priority'] ?? $report->priority,
            'description' => $validated['description'] ?? $report->description,
            'status' => $validated['status'] ?? $report->status,
            'image' => $request->file('image') ? $request->file('image')->store('reports', 'public') : $report->image,
        ]);

        return response()->json(['message' => 'Report updated successfully!', 'data' => $report], 200);
    }

    /**
     * Remove the specified report from storage.
     */
    public function destroy($folio)
    {
        $report = Report::where('folio', $folio)->first();

        if (!$report) {
            return response()->json(['message' => 'Report not found'], 404);
        }

        // Delete the report
        $report->delete();

        return response()->json(['message' => 'Report deleted successfully!'], 200);
    }
}

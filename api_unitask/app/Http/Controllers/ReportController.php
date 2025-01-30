<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use app\Models\Building;

class ReportController extends Controller
{
    // Mostrar todos los reportes
    public function index(Request $request)
    {
        $reports = Report::with([
                'building:buildingID,key',
                'room:roomID,name',
                'category:categoryID,name',
                'goods:goodID,name',
                'user:userID,name',
                'status:statusID,name'
            ])
            ->get();

        return response()->json($reports, 200);
    }

    public function todo()
    {
        $reports = Report::all();
        return response()->json($reports, 200);
    }

    // Crear un nuevo reporte
    public function store(Request $request)
    {
        $request->validate([
            'buildingID' => 'required|string|max:10|exists:buildings,buildingID',
            'roomID' => 'required|string|max:10|exists:rooms,roomID',
            'categoryID' => 'required|integer|exists:categories,categoryID',
            'goodID' => 'required|integer|exists:goods,goodID', 
            'priority' => 'required|in:Immediate,Normal',
            'description' => 'required|string',
            'image' => 'nullable|string',
            'matricula' => 'required|integer|exists:users,matricula',
            'status' => 'required|in:Pending,In Progress,Completed',
        ]);

        // Generar un folio único si no se proporciona
        $folio = $request->input('folio') ?? $this->generateUniqueFolio();

        $reportData = $request->all();
        $reportData['folio'] = $folio;

        $report = Report::create($reportData);

        return response()->json($report, 201);
    }

    // Método para generar un folio único
    private function generateUniqueFolio()
    {
        do {
            $folio = 'REP' . Str::upper(Str::random(7));
        } while (Report::where('folio', $folio)->exists());

        return $folio;
    }

    // Mostrar un reporte por folio
    public function show($folio)
    {
        $report = Report::with(['building', 'room', 'category', 'goods', 'user'])->findOrFail($folio);
        return response()->json($report, 200);
    }

    // Actualizar un reporte
    public function update(Request $request, $folio)
    {
        $request->validate([
            'buildingID' => 'nullable|string|max:10|exists:buildings,buildingID',
            'roomID' => 'nullable|string|max:10|exists:rooms,roomID',
            'categoryID' => 'nullable|integer|exists:categories,categoryID',
            'goodID' => 'nullable|integer|exists:goods,goodID', 
            'priority' => 'nullable|in:Immediate,Normal',
            'description' => 'nullable|string',
            'image' => 'nullable|string',
            'matricula' => 'nullable|integer|exists:users,matricula',
            'status' => 'nullable|in:Pending,Diagnostiqued,Completed',
        ]);

        $report = Report::findOrFail($folio);
        $report->update($request->all());

        return response()->json($report, 200);
    }

    // Eliminar un reporte
    public function destroy($folio)
    {
        $report = Report::findOrFail($folio);
        $report->delete();

        return response()->json(['message' => 'Report deleted successfully'], 200);
    }

    public function GetdiagnosticNot ()
    {
        $reports = Report::where('status', 'Diagnostiqued')->get();
        return response()->json($reports, 200);
    }
}

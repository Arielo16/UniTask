<?php

namespace App\Http\Controllers;

use App\Models\Report;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\Building;

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
            'buildingID' => 'required|integer|exists:buildings,buildingID', 
            'roomID' => 'required|integer|exists:rooms,roomID', 
            'categoryID' => 'required|integer|exists:categories,categoryID',
            'goodID' => 'required|integer|exists:goods,goodID', 
            'priority' => 'required|in:Immediate,Normal',
            'description' => 'required|string',
            'image' => 'nullable|string',
            'userID' => 'required|integer|exists:users,userID', 
            'statusID' => 'required|integer|exists:statuses,statusID', 
            'requires_approval' => 'boolean', 
            'involve_third_parties' => 'boolean', 
            'folio' => 'nullable|string|size:7|unique:reports,folio', 
        ]);

        // Generar un folio único si no se proporciona
        $folio = $request->input('folio') ?? $this->generateUniqueFolio();

        // Registro de depuración
        \Log::info('Generated folio: ' . $folio);

        $reportData = $request->all();
        $reportData['folio'] = $folio;

        $report = Report::create($reportData);

        return response()->json($report, 201);
    }

    // Método para generar un folio único
    private function generateUniqueFolio()
    {
        do {
            $folio = 'REP' . Str::upper(Str::random(4)); // Ajustado a 4 caracteres aleatorios
        } while (Report::where('folio', $folio)->exists());

        return $folio;
    }

    // Mostrar un reporte por folio
    public function show($folio)
    {
        $report = Report::with(['building', 'room', 'category', 'goods', 'user'])
            ->where('folio', $folio)
            ->firstOrFail();
        return response()->json($report, 200);
    }

    // Actualizar un reporte
    public function update(Request $request, $folio)
    {
        $request->validate([
            'buildingID' => 'nullable|integer|exists:buildings,buildingID', 
            'roomID' => 'nullable|integer|exists:rooms,roomID', 
            'categoryID' => 'nullable|integer|exists:categories,categoryID',
            'goodID' => 'nullable|integer|exists:goods,goodID', 
            'priority' => 'nullable|in:Immediate,Normal',
            'description' => 'nullable|string',
            'image' => 'nullable|string',
            'userID' => 'nullable|integer|exists:users,userID', 
            'statusID' => 'nullable|integer|exists:statuses,statusID', 
            'requires_approval' => 'boolean', 
            'involve_third_parties' => 'boolean', 
            'folio' => 'nullable|string|size:7|unique:reports,folio,' . $folio . ',folio', 
        ]);

        $report = Report::where('folio', $folio)->firstOrFail();
        $report->update($request->all());

        return response()->json($report, 200);
    }

    // Eliminar un reporte
    public function destroy($folio)
    {
        $report = Report::where('folio', $folio)->firstOrFail();
        $report->delete();

        return response()->json(['message' => 'Report deleted successfully'], 200);
    }

    public function GetdiagnosticNot ()
    {
        $reports = Report::where('statusID', 2)->get(); 
        return response()->json($reports, 200);
    }
}

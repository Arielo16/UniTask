<?php

namespace App\Http\Controllers;

use App\Models\Diagnostic;
use Illuminate\Http\Request;
use App\Models\Report;

class DiagnosticController extends Controller
{
    // Mostrar todos los diagnósticos
    public function index()
    {
        $diagnostics = Diagnostic::with('report')->get();
        return response()->json($diagnostics, 200);
    }

    public function todo()
    {
        $diagnostics = Diagnostic::all();
        return response()->json($diagnostics, 200);
    }

    // Crear un nuevo diagnóstico
    public function store(Request $request)
    {
        $request->validate([
            'folio' => 'required|string|max:10|exists:reports,folio',
            'description' => 'required|string',
            'images' => 'nullable|array', // Debe ser un array si se envía
            'images.*' => 'string', // Cada elemento del array debe ser una cadena (ruta de la imagen)
            'completed' => 'nullable|boolean',
        ]);

        if ($request->input('completed') == 1) {
            return response()->json(['message' => 'Cannot create a diagnostic with completed status.'], 400);
        }

        $diagnostic = Diagnostic::create($request->all());

        Report::where('folio', $request->folio)->update(['status' => 'Completed']);

        return response()->json($diagnostic, 201);
    }

    // Mostrar un diagnóstico específico
    public function show($id)
    {
        $diagnostic = Diagnostic::with('report')->findOrFail($id);
        return response()->json($diagnostic, 200);
    }

    // Actualizar un diagnóstico existente
    public function update(Request $request, $id)
    {
        $request->validate([
            'description' => 'nullable|string',
            'images' => 'nullable|array',
            'images.*' => 'string',
            'completed' => 'nullable|boolean',
        ]);

        $diagnostic = Diagnostic::findOrFail($id);
        $diagnostic->update($request->all());
        return response()->json($diagnostic, 200);
    }

    // Eliminar un diagnóstico
    public function destroy($id)
    {
        $diagnostic = Diagnostic::findOrFail($id);
        $diagnostic->delete();
        return response()->json(['message' => 'Diagnostic deleted successfully'], 200);
    }
}

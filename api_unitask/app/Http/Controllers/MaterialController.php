<?php

namespace App\Http\Controllers;

use App\Models\Material;
use Illuminate\Http\Request;

class MaterialController extends Controller
{
    // Obtener todos los materiales
    public function index()
    {
        $materials = Material::with('diagnosis')->get();
        return response()->json($materials, 200);
    }

    // Crear un nuevo material
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'supplier' => 'required|string|max:255',
            'quantity' => 'required|integer|min:1',
            'price' => 'required|numeric|min:0',
            'diagnosis_id' => 'required|exists:diagnoses,diagnosis_id',
        ]);

        $material = Material::create($request->all());
        return response()->json($material, 201);
    }

    // Obtener un material por ID
    public function show($id)
    {
        $material = Material::with('diagnosis')->findOrFail($id);
        return response()->json($material, 200);
    }

    // Actualizar un material
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'sometimes|string|max:255',
            'supplier' => 'sometimes|string|max:255',
            'quantity' => 'sometimes|integer|min:1',
            'price' => 'sometimes|numeric|min:0',
            'diagnosis_id' => 'sometimes|exists:diagnoses,diagnosis_id',
        ]);

        $material = Material::findOrFail($id);
        $material->update($request->all());
        return response()->json($material, 200);
    }

    // Eliminar un material
    public function destroy($id)
    {
        $material = Material::findOrFail($id);
        $material->delete();
        return response()->json(['message' => 'Material deleted successfully'], 200);
    }
}

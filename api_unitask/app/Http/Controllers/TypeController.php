<?php

namespace App\Http\Controllers;

use App\Models\Type;
use Illuminate\Http\Request;

class TypeController extends Controller
{
    // Obtener todos los tipos
    public function index()
    {
        $types = Type::all();
        return response()->json($types, 200);
    }

    // Crear un nuevo tipo
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $type = Type::create([
            'name' => $request->name,
        ]);

        return response()->json($type, 201);
    }

    // Mostrar un tipo específico
    public function show($typeID)
    {
        $type = Type::findOrFail($typeID);
        return response()->json($type, 200);
    }

    // Actualizar un tipo existente
    public function update(Request $request, $typeID)
    {
        $request->validate([
            'name' => 'nullable|string|max:255',
        ]);

        $type = Type::findOrFail($typeID);
        $type->update($request->all());
        return response()->json($type, 200);
    }

    // Eliminar un tipo
    public function destroy($typeID)
    {
        $type = Type::findOrFail($typeID);
        $type->delete();
        return response()->json(['message' => 'Type deleted successfully'], 200);
    }
}

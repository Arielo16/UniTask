<?php

namespace App\Http\Controllers;

use App\Models\Good;
use Illuminate\Http\Request;

class GoodController extends Controller
{
    // Mostrar todos los bienes
    public function index()
    {
        $goods = Good::with('category')->get(); 
        return response()->json($goods, 200);
    }

    // Crear un nuevo bien
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'categoryID' => 'required|integer|exists:categories,categoryID',
        ]);

        $good = Good::create($request->all());

        return response()->json($good, 201);
    }

    // Mostrar un bien por su ID
    public function show($id)
    {
        $good = Good::with('category')->findOrFail($id);
        return response()->json($good, 200);
    }

    // Actualizar un bien existente
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'nullable|string|max:255',
            'categoryID' => 'nullable|integer|exists:categories,categoryID',
        ]);

        $good = Good::findOrFail($id);
        $good->update($request->all());

        return response()->json($good, 200);
    }

    // Eliminar un bien
    public function destroy($id)
    {
        $good = Good::findOrFail($id);
        $good->delete();

        return response()->json(['message' => 'Good deleted successfully'], 200);
    }
}

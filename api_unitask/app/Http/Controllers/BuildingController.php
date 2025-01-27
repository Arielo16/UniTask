<?php

namespace App\Http\Controllers;

use App\Models\Building;
use Illuminate\Http\Request;

class BuildingController extends Controller
{
    // Mostrar todos los edificios
    public function index()
    {
        $buildings = Building::with('rooms')->get(); 
        return response()->json($buildings, 200);
    }

    // Crear un nuevo edificio
    public function store(Request $request)
    {
        $request->validate([
            'buildingID' => 'required|string|max:10|unique:buildings,buildingID',
        ]);

        $building = Building::create($request->all());
        return response()->json($building, 201);
    }

    // Mostrar un edificio específico por ID
    public function show($buildingID)
    {
        $building = Building::with('rooms')->findOrFail($buildingID);
        return response()->json($building, 200);
    }

    // Actualizar un edificio
    public function update(Request $request, $buildingID)
    {
        $request->validate([
            'buildingID' => 'required|string|max:1|unique:buildings,buildingID,' . $buildingID . ',buildingID', // Validar nuevo ID único
        ]);

        $building = Building::findOrFail($buildingID);
        $building->update($request->all());
        return response()->json($building, 200);
    }

    // Eliminar un edificio
    public function destroy($buildingID)
    {
        $building = Building::findOrFail($buildingID);
        $building->delete();
        return response()->json(['message' => 'Building deleted successfully'], 200);
    }
}

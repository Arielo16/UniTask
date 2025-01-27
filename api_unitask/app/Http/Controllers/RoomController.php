<?php

namespace App\Http\Controllers;

use App\Models\Room;
use Illuminate\Http\Request;

class RoomController extends Controller
{
    // Mostrar todos los salones
    public function index()
    {
        $rooms = Room::with(['building', 'type'])->get();
        return response()->json($rooms, 200);
    }

    // Crear un nuevo salón
    public function store(Request $request)
    {
        $request->validate([
            'roomID' => 'required|string|max:10|unique:rooms,roomID',
            'buildingID' => 'required|string|max:10|exists:buildings,buildingID',
            'typeID' => 'required|integer|exists:types,typeID',
        ]);

        $room = Room::create($request->all());
        return response()->json($room, 201);
    }

    // Mostrar un salón específico
    public function show($roomID, $buildingID)
    {
        $room = Room::with(['building', 'type'])->where('roomID', $roomID)->where('buildingID', $buildingID)->firstOrFail();
        return response()->json($room, 200);
    }

    // Actualizar un salón existente
    public function update(Request $request, $roomID, $buildingID)
    {
        $request->validate([
            'typeID' => 'nullable|integer|exists:types,typeID',
        ]);

        $room = Room::where('roomID', $roomID)->where('buildingID', $buildingID)->firstOrFail();
        $room->update($request->all());
        return response()->json($room, 200);
    }

    // Eliminar un salón
    public function destroy($roomID, $buildingID)
    {
        $room = Room::where('roomID', $roomID)->where('buildingID', $buildingID)->firstOrFail();
        $room->delete();
        return response()->json(['message' => 'Room deleted successfully'], 200);
    }
}

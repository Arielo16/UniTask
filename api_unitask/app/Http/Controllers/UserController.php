<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    // Obtener todos los usuarios
    public function index()
    {
        $users = User::all();
        return response()->json($users, 200);
    }

    // Crear un nuevo usuario
    public function store(Request $request)
    {
        $request->validate([
            'matricula' => 'required|string|max:20|unique:users',
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'middle_name' => 'nullable|string|max:255',
            'institutional_email' => 'required|string|email|max:255|unique:users,institutional_email',
            'password' => 'required|string|min:8',
            'birth_date' => 'required|date',
        ]);

        $user = User::create([
            'matricula' => $request->matricula,
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'middle_name' => $request->middle_name,
            'institutional_email' => $request->institutional_email,
            'password' => Hash::make($request->password), // Encriptar contraseña
            'birth_date' => $request->birth_date,
        ]);

        return response()->json($user, 201);
    }

    // Autenticar usuario
    public function login(Request $request)
    {
        $request->validate([
            'institutional_email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only('institutional_email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            return response()->json(['message' => 'Login successful', 'user' => $user], 200);
        } else {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }
    }

    // Mostrar un usuario específico
    public function show($matricula)
    {
        $user = User::findOrFail($matricula);
        return response()->json($user, 200);
    }

    // Actualizar un usuario existente
    public function update(Request $request, $matricula)
    {
        $request->validate([
            'first_name' => 'nullable|string|max:255',
            'last_name' => 'nullable|string|max:255',
            'middle_name' => 'nullable|string|max:255',
            'institutional_email' => 'nullable|string|email|max:255|unique:users,institutional_email,' . $matricula . ',matricula',
            'password' => 'nullable|string|min:8',
            'birth_date' => 'nullable|date',
        ]);

        $user = User::findOrFail($matricula);
        $data = $request->all();

        if ($request->has('password')) {
            $data['password'] = Hash::make($request->password);
        }

        $user->update($data);
        return response()->json($user, 200);
    }

    // Eliminar un usuario
    public function destroy($matricula)
    {
        $user = User::findOrFail($matricula);
        $user->delete();
        return response()->json(['message' => 'User deleted successfully'], 200);
    }
}

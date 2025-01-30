<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    // Verificar el estado de inicio de sesión del usuario
    public function verifyLogin(Request $request)
    {
        \Log::info('verifyLogin called', ['request' => $request->all()]);

        $credentials = $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        \Log::info('Credentials validated', ['credentials' => $credentials]);

        if (Auth::attempt($credentials)) {
            \Log::info('Authentication successful');
            //$request->session()->regenerate();
            return response()->json(['message' => 'Si'], 200);
        }

        \Log::info('Authentication failed');
        return response()->json(['message' => 'No'], 401);
    }

    // Cerrar sesión de usuario
    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return response()->json(['message' => 'Logout successful'], 200);
    }

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
            'name' => 'required|string|max:255',
            'lastname' => 'required|string|max:255',
            'secundlastname' => 'nullable|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email',
            'password' => 'required|string|min:8',
            'birthday' => 'required|date',
        ]);

        $user = User::create([
            'matricula' => $request->matricula,
            'name' => $request->name,
            'lastname' => $request->lastname,
            'secundlastname' => $request->secundlastname,
            'email' => $request->email,
            'password' => Hash::make($request->password), // Encriptar contraseña
            'birthday' => $request->birthday,
        ]);

        return response()->json($user, 201);
    }

    // Mostrar un usuario específico
    public function show($matricula)
    {
        $user = User::where('matricula', $matricula)->firstOrFail();
        return response()->json($user, 200);
    }

    // Actualizar un usuario existente
    public function update(Request $request, $matricula)
    {
        $request->validate([
            'name' => 'nullable|string|max:255',
            'lastname' => 'nullable|string|max:255',
            'secundlastname' => 'nullable|string|max:255',
            'email' => 'nullable|string|email|max:255|unique:users,email,' . $matricula . ',matricula',
            'password' => 'nullable|string|min:8',
            'birthday' => 'nullable|date',
        ]);

        $user = User::where('matricula', $matricula)->firstOrFail();
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
        $user = User::where('matricula', $matricula)->firstOrFail();
        $user->delete();
        return response()->json(['message' => 'User deleted successfully'], 200);
    }
}

<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{
    ReportController,
    BuildingController,
    GoodController,
    CategoryController,
    RoomController,
    DiagnosticController,
    UserController,
    TypeController,
    MovilController,
};

// Definición de las rutas
Route::prefix('reports')->group(function () {
    Route::get('get/', [ReportController::class, 'index']); // Obtener todos los reportes
    Route::get('todo/', [ReportController::class, 'todo']);
    Route::post('post/', [ReportController::class, 'store']);
    Route::get('get/{folio}', [ReportController::class, 'show']);
    Route::put('put/{folio}', [ReportController::class, 'update']);
    Route::delete('delete/{folio}', [ReportController::class, 'destroy']);
    Route::get('diagnostiqued', [ReportController::class, 'GetdiagnosticNot']);
});

Route::prefix('buildings')->group(function () {
    Route::get('get/', [BuildingController::class, 'index']);
    Route::post('post/', [BuildingController::class, 'store']);
    Route::get('get/{buildingID}', [BuildingController::class, 'show']);
    Route::put('put/{buildingID}', [BuildingController::class, 'update']);
    Route::delete('delete/{buildingID}', [BuildingController::class, 'destroy']);
});

Route::prefix('goods')->group(function () {
    Route::get('get/', [GoodController::class, 'index']);
    Route::post('post/', [GoodController::class, 'store']);
    Route::get('get/{good_id}', [GoodController::class, 'show']);
    Route::put('put/{good_id}', [GoodController::class, 'update']);
    Route::delete('delete/{good_id}', [GoodController::class, 'destroy']);
});

Route::prefix('categories')->group(function () {
    Route::get('get/', [CategoryController::class, 'index']); // Obtener todas las categorías
    Route::post('post/', [CategoryController::class, 'store']); // Crear una nueva categoría
    Route::get('get/{category_id}', [CategoryController::class, 'show']); // Obtener una categoría específica
    Route::put('put/{category_id}', [CategoryController::class, 'update']); // Actualizar una categoría
    Route::delete('delete/{category_id}', [CategoryController::class, 'destroy']); // Eliminar una categoría
});

Route::prefix('rooms')->group(function () {
    Route::get('get/', [RoomController::class, 'index']); // Obtener todos los salones
    Route::post('post/', [RoomController::class, 'store']); // Crear un nuevo salón
    Route::get('get/{room_id}/{building_id}', [RoomController::class, 'show']); // Obtener un salón específico
    Route::put('put/{room_id}/{building_id}', [RoomController::class, 'update']); // Actualizar un salón
    Route::delete('delete/{room_id}/{building_id}', [RoomController::class, 'destroy']); // Eliminar un salón
});

Route::prefix('diagnostics')->group(function () {
    Route::get('get/', [DiagnosticController::class, 'index']); // Obtener todos los diagnósticos
    Route::get('todo/', [DiagnosticController::class, 'todo']); // Obtener todos los diagnósticos
    Route::post('post/', [DiagnosticController::class, 'store']); // Crear un diagnóstico
    Route::get('get/{id}', [DiagnosticController::class, 'show']); // Obtener un diagnóstico específico
    Route::put('put/{id}', [DiagnosticController::class, 'update']); // Actualizar un diagnóstico
    Route::delete('delete/{id}', [DiagnosticController::class, 'destroy']); // Eliminar un diagnóstico
});

Route::prefix('users')->group(function () {
    Route::post('verifyLogin/', [UserController::class, 'verifyLogin']); // Verificar el estado de inicio de sesión del usuario


    Route::get('get/', [UserController::class, 'index']); // Obtener todos los usuarios
    Route::post('post/', [UserController::class, 'store']); // Crear un usuario
    Route::get('get/{matricula}', [UserController::class, 'show']); // Obtener un usuario específico
    Route::put('put/{matricula}', [UserController::class, 'update']); // Actualizar un usuario
    Route::delete('delete/{matricula}', [UserController::class, 'destroy']); // Eliminar un usuario
});

Route::prefix('types')->group(function () {
    Route::get('get/', [TypeController::class, 'index']); // Obtener todos los tipos
    Route::post('post/', [TypeController::class, 'store']); // Crear un tipo
    Route::get('get/{typeID}', [TypeController::class, 'show']); // Obtener un tipo específico
    Route::put('put/{typeID}', [TypeController::class, 'update']); // Actualizar un tipo
    Route::delete('delete/{typeID}', [TypeController::class, 'destroy']); // Eliminar un tipo
});

Route::get('/getallreports', [MovilController::class, 'getAllReports']);
Route::get('/getalldiagnostics', [MovilController::class, 'getAllDiagnostics']);
Route::get('/getalldiagnosticsstatus', [MovilController::class, 'getAllDiagnosticsStatus']);
Route::post('/postdiagnostic', [MovilController::class, 'postDiagnostic']);
Route::put('/updatediagnosticstatus', [MovilController::class, 'updateDiagnosticStatus']);
Route::get('/getreportbyfolio', [MovilController::class, 'getReportByFolio']);
Route::post('/postmaterials', [MovilController::class, 'postMaterials']);

Route::get('/getmaterialsbydiagnostic/{diagnosticID}', [MovilController::class, 'getMaterialsByDiagnostic']);

Route::get('/getmaterialsbydiagnostic/{diagnosticID}', [MovilController::class, 'getMaterialsByDiagnostic']);



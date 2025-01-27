<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{
    ReportController,
    BuildingController,
    GoodController
};

// Definición de las rutas
Route::prefix('reports')->group(function () {
    Route::get('get/', [ReportController::class, 'index']);
    Route::get('todo/', [ReportController::class, 'todo']);
    Route::post('post/', [ReportController::class, 'store']);
    Route::get('get/{folio}', [ReportController::class, 'show']);
    Route::put('put/{folio}', [ReportController::class, 'update']);
    Route::delete('delete/{folio}', [ReportController::class, 'destroy']);
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

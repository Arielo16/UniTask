<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ReportController;

// Definición de las rutas
Route::prefix('reports')->group(function () {
    Route::get('get/', [ReportController::class, 'index']);
    Route::post('post/', [ReportController::class, 'store']);
    Route::get('get/{folio}', [ReportController::class, 'show']);
    Route::put('put/{folio}', [ReportController::class, 'update']);
    Route::delete('delete/{folio}', [ReportController::class, 'destroy']);
});

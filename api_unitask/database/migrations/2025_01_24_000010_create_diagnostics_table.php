<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('diagnostics', function (Blueprint $table) {
            $table->id('diagnosticID'); 
            $table->unsignedBigInteger('reportID');
            $table->text('description');
            $table->mediumText('images');
            $table->enum('status', ['Enviado', 'EnviadoAprobacion', 'EnProceso', 'Terminado']);
            $table->timestamps();

            // Llave foránea
            $table->foreign('reportID')->references('reportID')->on('reports')->onDelete('cascade');
        });

        // Insertar datos en la tabla "diagnostics"
        DB::table('diagnostics')->insert([
            [
                'reportID' => 1,
                'description' => 'Diagnostic for broken chair in room 101',
                'images' => '',
                'status' => 'Enviado',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'reportID' => 2,
                'description' => 'Diagnostic for window repair in room 202',
                'images' => '',
                'status' => 'EnviadoAprobacion',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'reportID' => 3,
                'description' => 'Diagnostic for electrical issue in room 303',
                'images' => '',
                'status' => 'EnProceso',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'reportID' => 4,
                'description' => 'Diagnostic for broken window in room 404',
                'images' => '',
                'status' => 'Terminado',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'reportID' => 5,
                'description' => 'Diagnostic for plumbing issue in room 505',
                'images' => '',
                'status' => 'Enviado',
                'created_at' => now(),
                'updated_at' => now()
            ],
        ]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('diagnostics');
    }
};

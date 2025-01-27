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
            $table->id('diagnosticID'); // FolioDia (PK)
            $table->string('folio', 10); // Folio (FK)
            $table->text('description'); // Description
            $table->json('images')->nullable(); // Imágenes almacenadas como JSON
            $table->boolean('completed')->default(false); // Terminado (boolean)
            $table->timestamps();

            // Llave foránea
            $table->foreign('folio')->references('folio')->on('reports')->onDelete('cascade');
        });

        DB::table('diagnostics')->insert([
            [
                'folio' => 'REPZH17CUT',
                'description' => 'Diagnóstico de la silla rota en el aula A101',
                'images' => json_encode(['diagnostico_silla1.jpg', 'diagnostico_silla2.jpg']),
                'completed' => false,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REPZH18CUT',
                'description' => 'Diagnóstico del cambio de bombillo en el aula B202',
                'images' => json_encode(['diagnostico_bombillo1.jpg']),
                'completed' => true,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REPZH19CUT',
                'description' => 'Diagnóstico de la ventana rota en el aula C303',
                'images' => json_encode(['diagnostico_ventana1.jpg']),
                'completed' => false,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REPZH20CUT',
                'description' => 'Diagnóstico de la fuga de agua en el laboratorio E404',
                'images' => json_encode(['diagnostico_fuga1.jpg']),
                'completed' => true,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REPZH21CUT',
                'description' => 'Diagnóstico del aire acondicionado en el aula F505',
                'images' => json_encode(['diagnostico_aire1.jpg']),
                'completed' => false,
                'created_at' => now(),
                'updated_at' => now()
            ],
            // Agrega más datos según sea necesario
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

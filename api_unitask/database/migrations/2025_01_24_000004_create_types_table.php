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
        Schema::create('types', function (Blueprint $table) {
            $table->id('typeID'); // TipoID como llave primaria
            $table->string('name'); // Nombre
            $table->timestamps(); // created_at y updated_at
        });

        // Insertar datos en la tabla "types"
        DB::table('types')->insert([
            ['name' => 'Aula', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Laboratorio', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Oficina', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Auditorio', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Biblioteca', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Baño', 'created_at' => now(), 'updated_at' => now()],
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
        Schema::dropIfExists('types');
    }
};

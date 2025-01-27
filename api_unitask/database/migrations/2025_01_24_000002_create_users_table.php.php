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
        Schema::create('users', function (Blueprint $table) {
            $table->string('matricula', 20)->primary(); // Matricula como llave primaria
            $table->string('first_name'); // Nombre
            $table->string('last_name'); // PrimerApellido
            $table->string('middle_name')->nullable(); // SegundoApellido
            $table->string('institutional_email')->unique(); // Correo institucional
            $table->string('password'); // Contraseña
            $table->date('birth_date'); // Fecha-Nacimiento
            $table->timestamps(); // Timestamps (created_at, updated_at)
        });

        DB::table('users')->insert([
            [
                'matricula' => '23090565',
                'first_name' => 'Juan',
                'last_name' => 'Pérez',
                'middle_name' => 'González',
                'institutional_email' => 'juan.perez@uni.edu',
                'password' => bcrypt('password123'),
                'birth_date' => '1990-01-01',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'matricula' => '23090566',
                'first_name' => 'María',
                'last_name' => 'López',
                'middle_name' => 'Martínez',
                'institutional_email' => 'maria.lopez@uni.edu',
                'password' => bcrypt('password123'),
                'birth_date' => '1992-02-02',
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
        Schema::dropIfExists('users');
    }
};

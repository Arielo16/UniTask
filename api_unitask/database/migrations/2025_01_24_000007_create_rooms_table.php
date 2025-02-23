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
        Schema::create('rooms', function (Blueprint $table) {
            $table->id('roomID', 10); // ID del salón autoincrementable
            $table->string('name');
            $table->string('keyID');
            $table->unsignedBigInteger('buildingID');
            $table->unsignedBigInteger('typeID'); 
            $table->timestamps();

            // Llaves foráneas
            $table->foreign('buildingID')->references('buildingID')->on('buildings')->onDelete('cascade');
            $table->foreign('typeID')->references('typeID')->on('types')->onDelete('cascade');
        });

        // Insertar datos en la tabla "rooms"
        DB::table('rooms')->insert([
            ['name' => 'Aula 101', 'keyID' => 'A101', 'buildingID' => 1, 'typeID' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Laboratorio 202', 'keyID' => 'B202', 'buildingID' => 2, 'typeID' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Oficina 303', 'keyID' => 'C303', 'buildingID' => 3, 'typeID' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Auditorio 404', 'keyID' => 'D404', 'buildingID' => 4, 'typeID' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Biblioteca 505', 'keyID' => 'E505', 'buildingID' => 5, 'typeID' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Baño 606', 'keyID' => 'F606', 'buildingID' => 6, 'typeID' => 6, 'created_at' => now(), 'updated_at' => now()],
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
        Schema::dropIfExists('rooms');
    }
};

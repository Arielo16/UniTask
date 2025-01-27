<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

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
            $table->string('roomID', 10); // ID del salón
            $table->string('buildingID', 10); // ID del edificio (FK)
            $table->unsignedBigInteger('typeID'); // Tipo de salón (FK)

            $table->primary(['roomID', 'buildingID']); // Llave compuesta: roomID y buildingID

            // Llaves foráneas
            $table->foreign('buildingID')->references('buildingID')->on('buildings')->onDelete('cascade');
            $table->foreign('typeID')->references('typeID')->on('types')->onDelete('cascade');

            $table->timestamps();
        });

        // Insertar datos en la tabla "rooms"
        DB::table('rooms')->insert([
            ['roomID' => 'A101', 'buildingID' => 'A', 'typeID' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['roomID' => 'B202', 'buildingID' => 'B', 'typeID' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['roomID' => 'C303', 'buildingID' => 'C', 'typeID' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['roomID' => 'E404', 'buildingID' => 'E', 'typeID' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['roomID' => 'F505', 'buildingID' => 'F', 'typeID' => 1, 'created_at' => now(), 'updated_at' => now()],
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

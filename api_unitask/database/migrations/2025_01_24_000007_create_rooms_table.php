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
            $table->string('key');
            $table->unsignedBigInteger('buildingID');
            $table->unsignedBigInteger('typeID'); 
            $table->timestamps();

            // Llaves foráneas
            $table->foreign('buildingID')->references('buildingID')->on('buildings')->onDelete('cascade');
            $table->foreign('typeID')->references('typeID')->on('types')->onDelete('cascade');
        });

        // Insertar datos en la tabla "rooms"
        //DB::table('rooms')->insert([
            //['name' => 'M101', 'buildingID' => 'M', 'typeID' => '', 'created_at' => now(), 'updated_at' => now()],
        //]);
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

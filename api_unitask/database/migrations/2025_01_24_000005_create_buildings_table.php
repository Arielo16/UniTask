<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up()
    {
        Schema::create('buildings', function (Blueprint $table) {
            $table->id('buildingID'); 
            $table->string('name'); 
            $table->string('keyID'); 
            $table->timestamps();
        });

        DB::table('buildings')->insert([
            ['name' => 'Building A', 'keyID' => 'A', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building B', 'keyID' => 'B', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building C', 'keyID' => 'C', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building E', 'keyID' => 'E', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building F', 'keyID' => 'F', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building G', 'keyID' => 'G', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building H', 'keyID' => 'H', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building I', 'keyID' => 'I', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building J', 'keyID' => 'J', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building K', 'keyID' => 'K', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building R', 'keyID' => 'R', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building N', 'keyID' => 'N', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building M', 'keyID' => 'M', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building T', 'keyID' => 'T', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building X', 'keyID' => 'X', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building Z', 'keyID' => 'Z', 'created_at' => now(), 'updated_at' => now()],
        ]);
    }

    public function down()
    {
        Schema::dropIfExists('buildings');
    }
};

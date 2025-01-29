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
            $table->string('key'); 
            $table->timestamps();
        });

        DB::table('buildings')->insert([
            ['name' => 'Building A', 'key' => 'A', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building B', 'key' => 'B', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building C', 'key' => 'C', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building E', 'key' => 'E', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building F', 'key' => 'F', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building G', 'key' => 'G', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building H', 'key' => 'H', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building I', 'key' => 'I', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building J', 'key' => 'J', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building K', 'key' => 'K', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building R', 'key' => 'R', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building N', 'key' => 'N', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building M', 'key' => 'M', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building T', 'key' => 'T', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building X', 'key' => 'X', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Building Z', 'key' => 'Z', 'created_at' => now(), 'updated_at' => now()],
        ]);
    }

    public function down()
    {
        Schema::dropIfExists('buildings');
    }
};

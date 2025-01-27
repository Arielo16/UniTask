<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('buildings', function (Blueprint $table) {
            $table->string('buildingID', 1)->primary(); 
            $table->timestamps();
        });

        DB::table('buildings')->insert([
            ['buildingID' => 'A', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'B', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'C', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'E', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'F', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'G', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'H', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'I', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'J', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'K', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'R', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'N', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'M', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'T', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'X', 'created_at' => now(), 'updated_at' => now()],
            ['buildingID' => 'Z', 'created_at' => now(), 'updated_at' => now()],
            
        ]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('buildings');
    }
};

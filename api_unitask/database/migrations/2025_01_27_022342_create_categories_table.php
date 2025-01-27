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
        Schema::create('categories', function (Blueprint $table) {
            $table->id('categoryID');
            $table->string('name', 100); 
            $table->timestamps();  
        });

        // Insertar categorías relacionadas con reportes
        DB::table('categories')->insert([
            ['name' => 'Carpintería', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Aluminios', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Electricidad', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Cristales', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Fontanería', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Pintura', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Aire Acondicionado', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Plomería', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Sistemas eléctricos (Cableado, redes)', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Sistemas de protección contra incendios', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Albañilería', 'created_at' => now(), 'updated_at' => now()],
        ]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('categories');
    }
};

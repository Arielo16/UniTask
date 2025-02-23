<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up()
    {
        Schema::create('materials', function (Blueprint $table) {
            $table->id('materialID'); 
            $table->string('name'); 
            $table->string('supplier'); // Este es el proveedor
            $table->integer('quantity'); 
            $table->decimal('price', 10, 2); 
            $table->unsignedBigInteger('diagnosticID'); 
            $table->timestamps();

            $table->foreign('diagnosticID')->references('diagnosticID')->on('diagnostics')->onDelete('cascade');
        });

        // Insertar datos en la tabla "materials"
        DB::table('materials')->insert([
            [
                'name' => 'Wooden Planks',
                'supplier' => 'Wood Suppliers Inc.',
                'quantity' => 50,
                'price' => 15.00,
                'diagnosticID' => 1,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'name' => 'Aluminum Sheets',
                'supplier' => 'Aluminum Co.',
                'quantity' => 30,
                'price' => 25.00,
                'diagnosticID' => 2,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'name' => 'Electrical Wires',
                'supplier' => 'Electrical Supplies Ltd.',
                'quantity' => 100,
                'price' => 5.00,
                'diagnosticID' => 3,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'name' => 'Glass Panels',
                'supplier' => 'Glassworks',
                'quantity' => 20,
                'price' => 50.00,
                'diagnosticID' => 4,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'name' => 'PVC Pipes',
                'supplier' => 'Plumbing Supplies Co.',
                'quantity' => 40,
                'price' => 10.00,
                'diagnosticID' => 5,
                'created_at' => now(),
                'updated_at' => now()
            ],
            // Agrega más datos según sea necesario
        ]);
    }

    public function down()
    {
        Schema::dropIfExists('materials');
    }
};

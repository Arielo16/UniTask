<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up()
    {
        Schema::create('reports', function (Blueprint $table) {
            $table->id('reportID'); 
            $table->string('folio', 7)->unique(); 
            $table->unsignedBigInteger('buildingID'); 
            $table->unsignedBigInteger('roomID'); 
            $table->unsignedBigInteger('categoryID'); 
            $table->unsignedBigInteger('goodID'); 
            $table->enum('priority', ['Immediate', 'Normal']); 
            $table->text('description'); 
            $table->mediumText('image')->nullable(); 
            $table->unsignedBigInteger('userID'); 
            $table->unsignedBigInteger('statusID'); 
            $table->boolean('requires_approval')->default(false); 
            $table->boolean('involve_third_parties')->default(false); 
            $table->timestamps(); 

            $table->foreign('buildingID')->references('buildingID')->on('buildings')->onDelete('cascade');
            $table->foreign('roomID')->references('roomID')->on('rooms')->onDelete('cascade');
            $table->foreign('categoryID')->references('categoryID')->on('categories')->onDelete('cascade');
            $table->foreign('goodID')->references('goodID')->on('goods')->onDelete('cascade');
            $table->foreign('userID')->references('userID')->on('users')->onDelete('cascade');
            $table->foreign('statusID')->references('statusID')->on('statuses')->onDelete('cascade');
        });

        DB::table('reports')->insert([
            [
                'folio' => 'REP0001',
                'buildingID' => 1,
                'roomID' => 1,
                'categoryID' => 1,
                'goodID' => 1,
                'priority' => 'Immediate',
                'description' => 'Broken chair in room 101',
                'image' => null,
                'userID' => 1,
                'statusID' => 1,
                'requires_approval' => false,
                'involve_third_parties' => false,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REP0002',
                'buildingID' => 2,
                'roomID' => 2,
                'categoryID' => 2,
                'goodID' => 2,
                'priority' => 'Normal',
                'description' => 'Window needs repair in room 202',
                'image' => null,
                'userID' => 2,
                'statusID' => 2,
                'requires_approval' => true,
                'involve_third_parties' => false,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REP0003',
                'buildingID' => 3,
                'roomID' => 3,
                'categoryID' => 3,
                'goodID' => 3,
                'priority' => 'Immediate',
                'description' => 'Electrical issue in room 303',
                'image' => null,
                'userID' => 2,
                'statusID' => 3,
                'requires_approval' => false,
                'involve_third_parties' => true,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REP0004',
                'buildingID' => 4,
                'roomID' => 4,
                'categoryID' => 4,
                'goodID' => 4,
                'priority' => 'Normal',
                'description' => 'Broken window in room 404',
                'image' => null,
                'userID' => 1,
                'statusID' => 4,
                'requires_approval' => true,
                'involve_third_parties' => false,
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REP0005',
                'buildingID' => 5,
                'roomID' => 5,
                'categoryID' => 5,
                'goodID' => 5,
                'priority' => 'Immediate',
                'description' => 'Plumbing issue in room 505',
                'image' => null,
                'userID' => 1,
                'statusID' => 1,
                'requires_approval' => false,
                'involve_third_parties' => true,
                'created_at' => now(),
                'updated_at' => now()
            ],
            // Agrega más datos según sea necesario
        ]);
    }

    public function down()
    {
        Schema::dropIfExists('reports');
    }
};

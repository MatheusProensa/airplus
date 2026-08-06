package com.sulake.habbo.room.object.visualization.furniture
{
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   
   public class FurnitureParticleSystemEmitter extends FurnitureParticleSystemParticle
   {
      public static const SHAPE_CONE:String = "cone";
      
      public static const SHAPE_PLANE:String = "plane";
      
      public static const SHAPE_SPHERE:String = "sphere";
      
      private var _name:String;
      
      private var _roomObjectSpriteId:int = -1;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_Number_1:Number;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_Vector3D_1:Vector3D;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_Number_2:Number = 0.1;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_Number_3:Number;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_Number_4:Number;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_String_1:String;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_Array_1:Array;
      
      private var _particles:Array = [];
      
      private var _maxNumberOfParticles:int;
      
      private var _particlesPerFrame:int;
      
      private var _emittedParticles:int;
      
      private var _fuseTime:int = 10;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_Number_5:Number = 1;
      
      private var _hasIgnited:Boolean = false;
      
      private var UnknownVarFromFurnitureParticleSystemEmitter_Int_1:int = 1;
      
      public function FurnitureParticleSystemEmitter(param1:String = "", param2:int = -1)
      {
         super();
         _name = param1;
         _roomObjectSpriteId = param2;
         UnknownVarFromFurnitureParticleSystemEmitter_Array_1 = [];
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_ in _particles)
         {
            _loc1_.dispose();
         }
         _particles = null;
         UnknownVarFromFurnitureParticleSystemEmitter_Vector3D_1 = null;
         UnknownVarFromFurnitureParticleSystemEmitter_Array_1 = null;
         super.dispose();
      }
      
      public function setup(param1:int, param2:int, param3:Number, param4:Vector3D, param5:Number, param6:Number, param7:String, param8:Number, param9:int, param10:int) : void
      {
         _maxNumberOfParticles = param1;
         _particlesPerFrame = param2;
         UnknownVarFromFurnitureParticleSystemEmitter_Number_1 = param3;
         UnknownVarFromFurnitureParticleSystemEmitter_Vector3D_1 = param4;
         UnknownVarFromFurnitureParticleSystemEmitter_Vector3D_1.normalize();
         UnknownVarFromFurnitureParticleSystemEmitter_Number_3 = param5;
         UnknownVarFromFurnitureParticleSystemEmitter_Number_4 = param6;
         UnknownVarFromFurnitureParticleSystemEmitter_String_1 = param7;
         _fuseTime = param9;
         UnknownVarFromFurnitureParticleSystemEmitter_Number_5 = param8;
         UnknownVarFromFurnitureParticleSystemEmitter_Int_1 = param10;
         reset();
      }
      
      public function reset() : void
      {
         for each(var _loc1_ in _particles)
         {
            _loc1_.dispose();
         }
         _particles = [];
         _emittedParticles = 0;
         _hasIgnited = false;
         this.init(0,0,0,UnknownVarFromFurnitureParticleSystemEmitter_Vector3D_1,UnknownVarFromFurnitureParticleSystemEmitter_Number_1,UnknownVarFromFurnitureParticleSystemEmitter_Number_2,_fuseTime,true);
      }
      
      public function copyStateFrom(param1:FurnitureParticleSystemEmitter, param2:Number) : void
      {
         super.copy(param1,param2);
         UnknownVarFromFurnitureParticleSystemEmitter_Number_1 = param1.UnknownVarFromFurnitureParticleSystemEmitter_Number_1;
         UnknownVarFromFurnitureParticleSystemEmitter_Vector3D_1 = param1.UnknownVarFromFurnitureParticleSystemEmitter_Vector3D_1;
         UnknownVarFromFurnitureParticleSystemEmitter_Number_3 = param1.UnknownVarFromFurnitureParticleSystemEmitter_Number_3;
         UnknownVarFromFurnitureParticleSystemEmitter_Number_4 = param1.UnknownVarFromFurnitureParticleSystemEmitter_Number_4;
         UnknownVarFromFurnitureParticleSystemEmitter_String_1 = param1.UnknownVarFromFurnitureParticleSystemEmitter_String_1;
         _fuseTime = param1._fuseTime;
         UnknownVarFromFurnitureParticleSystemEmitter_Number_5 = param1.UnknownVarFromFurnitureParticleSystemEmitter_Number_5;
         UnknownVarFromFurnitureParticleSystemEmitter_Int_1 = param1.UnknownVarFromFurnitureParticleSystemEmitter_Int_1;
         UnknownVarFromFurnitureParticleSystemEmitter_Number_2 = param1.UnknownVarFromFurnitureParticleSystemEmitter_Number_2;
         _hasIgnited = param1._hasIgnited;
      }
      
      public function configureParticle(param1:int, param2:Boolean, param3:Array, param4:Boolean) : void
      {
         var _loc5_:Dictionary = new Dictionary();
         _loc5_["lifeTime"] = param1;
         _loc5_["isEmitter"] = param2;
         _loc5_["frames"] = param3;
         _loc5_["fade"] = param4;
         UnknownVarFromFurnitureParticleSystemEmitter_Array_1.push(_loc5_);
      }
      
      override protected function ignite() : void
      {
         _hasIgnited = true;
         if(_emittedParticles < _maxNumberOfParticles)
         {
            if(this.age > 1)
            {
               releaseParticles(this,this.direction);
            }
         }
      }
      
      private function releaseParticles(param1:FurnitureParticleSystemParticle, param2:Vector3D = null) : void
      {
         var _loc8_:FurnitureParticleSystemParticle = null;
         var _loc3_:Dictionary = null;
         var _loc10_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         if(!param2)
         {
            param2 = new Vector3D();
         }
         var _loc9_:Vector3D = new Vector3D();
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         _loc3_ = getRandomParticleConfiguration();
         _loc7_ = 0;
         while(_loc7_ < _particlesPerFrame)
         {
            switch(UnknownVarFromFurnitureParticleSystemEmitter_String_1)
            {
               case "cone":
                  _loc9_.x = randomBoolean(0.5) ? Math.random() : -Math.random();
                  _loc9_.y = -(Math.random() + 1);
                  _loc9_.z = randomBoolean(0.5) ? Math.random() : -Math.random();
                  break;
               case "plane":
                  _loc9_.x = randomBoolean(0.5) ? Math.random() : -Math.random();
                  _loc9_.y = 0;
                  _loc9_.z = randomBoolean(0.5) ? Math.random() : -Math.random();
                  break;
               case "sphere":
                  _loc9_.x = randomBoolean(0.5) ? Math.random() : -Math.random();
                  _loc9_.y = randomBoolean(0.5) ? Math.random() : -Math.random();
                  _loc9_.z = randomBoolean(0.5) ? Math.random() : -Math.random();
            }
            _loc9_.normalize();
            _loc8_ = new FurnitureParticleSystemParticle();
            if(_loc3_)
            {
               _loc10_ = Math.floor(Math.random() * _loc3_["lifeTime"] + 10);
               _loc4_ = Boolean(_loc3_["isEmitter"]);
               _loc6_ = _loc3_["frames"];
               _loc5_ = Boolean(_loc3_["fade"]);
            }
            else
            {
               _loc10_ = Math.floor(Math.random() * 20 + 10);
               _loc4_ = false;
               _loc6_ = [];
            }
            _loc8_.init(param1.x,param1.y,param1.z,_loc9_,UnknownVarFromFurnitureParticleSystemEmitter_Number_5,UnknownVarFromFurnitureParticleSystemEmitter_Number_2,_loc10_,_loc4_,_loc6_,_loc5_);
            _particles.push(_loc8_);
            _emittedParticles++;
            _loc7_++;
         }
      }
      
      private function getRandomParticleConfiguration() : Dictionary
      {
         var _loc1_:int = Math.floor(Math.random() * UnknownVarFromFurnitureParticleSystemEmitter_Array_1.length);
         return UnknownVarFromFurnitureParticleSystemEmitter_Array_1[_loc1_];
      }
      
      override public function update() : void
      {
         super.update();
         accumulateForces();
         verlet();
         satisfyConstraints();
         if(!isAlive && _emittedParticles < _maxNumberOfParticles)
         {
            if(this.age % UnknownVarFromFurnitureParticleSystemEmitter_Int_1 == 0)
            {
               releaseParticles(this,this.direction);
            }
         }
      }
      
      public function verlet() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         if(isAlive || _emittedParticles < _maxNumberOfParticles)
         {
            _loc2_ = this.x;
            _loc3_ = this.y;
            _loc4_ = this.z;
            this.x = (2 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * this.x - (1 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * this.lastX;
            this.y = (2 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * this.y - (1 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * this.lastY + UnknownVarFromFurnitureParticleSystemEmitter_Number_3 * UnknownVarFromFurnitureParticleSystemEmitter_Number_2 * UnknownVarFromFurnitureParticleSystemEmitter_Number_2;
            this.z = (2 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * this.z - (1 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * this.lastZ;
            this.lastX = _loc2_;
            this.lastY = _loc3_;
            this.lastZ = _loc4_;
         }
         var _loc1_:Array = [];
         for each(_loc5_ in _particles)
         {
            _loc5_.update();
            _loc2_ = _loc5_.x;
            _loc3_ = _loc5_.y;
            _loc4_ = _loc5_.z;
            _loc5_.x = (2 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * _loc5_.x - (1 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * _loc5_.lastX;
            _loc5_.y = (2 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * _loc5_.y - (1 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * _loc5_.lastY + UnknownVarFromFurnitureParticleSystemEmitter_Number_3 * UnknownVarFromFurnitureParticleSystemEmitter_Number_2 * UnknownVarFromFurnitureParticleSystemEmitter_Number_2;
            _loc5_.z = (2 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * _loc5_.z - (1 - UnknownVarFromFurnitureParticleSystemEmitter_Number_4) * _loc5_.lastZ;
            _loc5_.lastX = _loc2_;
            _loc5_.lastY = _loc3_;
            _loc5_.lastZ = _loc4_;
            if(_loc5_.y > 10 || !_loc5_.isAlive)
            {
               _loc1_.push(_loc5_);
            }
         }
         for each(_loc5_ in _loc1_)
         {
            if(!_loc5_.isEmitter)
            {
            }
            _particles.splice(_particles.indexOf(_loc5_),1);
            _loc5_.dispose();
         }
      }
      
      private function satisfyConstraints() : void
      {
      }
      
      private function accumulateForces() : void
      {
         for each(var _loc1_ in _particles)
         {
         }
      }
      
      public function get particles() : Array
      {
         return _particles;
      }
      
      public function get hasIgnited() : Boolean
      {
         return _hasIgnited;
      }
      
      private function randomBoolean(param1:Number) : Boolean
      {
         return Math.random() < param1;
      }
      
      public function get roomObjectSpriteId() : int
      {
         return _roomObjectSpriteId;
      }
   }
}


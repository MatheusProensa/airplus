package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   
   public class FurnitureParticleSystem
   {
      private var _emitters:Map;
      
      private var _visualization:AnimatedFurnitureVisualization;
      
      private var UnknownVarFromFurnitureParticleSystem_Int_1:int;
      
      private var UnknownVarFromFurnitureParticleSystem_Int_2:int;
      
      private var _offsetY:int;
      
      private var UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1:FurnitureParticleSystemEmitter;
      
      private var UnknownVarFromFurnitureParticleSystem_BitmapData_1:BitmapData;
      
      private var UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1:IRoomObjectSprite;
      
      private var UnknownVarFromFurnitureParticleSystem_Boolean_1:Boolean = false;
      
      private var UnknownVarFromFurnitureParticleSystem_Int_3:int = 0;
      
      private var UnknownVarFromFurnitureParticleSystem_Int_4:int = 0;
      
      private var UnknownVarFromFurnitureParticleSystem_Number_1:Number = 1;
      
      private var UnknownVarFromFurnitureParticleSystem_BitmapData_2:BitmapData;
      
      private var UnknownVarFromFurnitureParticleSystem_ColorTransform_1:ColorTransform;
      
      private var UnknownVarFromFurnitureParticleSystem_ColorTransform_2:ColorTransform;
      
      private var UnknownVarFromFurnitureParticleSystem_Matrix_1:Matrix;
      
      private var UnknownVarFromFurnitureParticleSystem_Matrix_2:Matrix;
      
      private var UnknownVarFromFurnitureParticleSystem_Number_2:Number = 1;
      
      private var _bgColor:uint = 4278190080;
      
      public function FurnitureParticleSystem(param1:AnimatedFurnitureVisualization)
      {
         super();
         _emitters = new Map();
         _visualization = param1;
         UnknownVarFromFurnitureParticleSystem_ColorTransform_1 = new ColorTransform();
         UnknownVarFromFurnitureParticleSystem_ColorTransform_1.alphaMultiplier = 1;
         UnknownVarFromFurnitureParticleSystem_ColorTransform_2 = new ColorTransform();
         UnknownVarFromFurnitureParticleSystem_Matrix_1 = new Matrix();
         UnknownVarFromFurnitureParticleSystem_Matrix_2 = new Matrix();
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _emitters)
         {
            _loc1_.dispose();
         }
         _emitters = null;
         if(UnknownVarFromFurnitureParticleSystem_BitmapData_1)
         {
            UnknownVarFromFurnitureParticleSystem_BitmapData_1.dispose();
            UnknownVarFromFurnitureParticleSystem_BitmapData_1 = null;
         }
         if(UnknownVarFromFurnitureParticleSystem_BitmapData_2)
         {
            UnknownVarFromFurnitureParticleSystem_BitmapData_2.dispose();
            UnknownVarFromFurnitureParticleSystem_BitmapData_2 = null;
         }
         UnknownVarFromFurnitureParticleSystem_ColorTransform_1 = null;
         UnknownVarFromFurnitureParticleSystem_ColorTransform_2 = null;
         UnknownVarFromFurnitureParticleSystem_Matrix_1 = null;
         UnknownVarFromFurnitureParticleSystem_Matrix_2 = null;
      }
      
      public function reset() : void
      {
         if(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1)
         {
            UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.reset();
         }
         UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1 = null;
         UnknownVarFromFurnitureParticleSystem_Boolean_1 = false;
         updateCanvas();
      }
      
      public function setAnimation(param1:int) : void
      {
         if(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1)
         {
            UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.reset();
         }
         UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1 = _emitters[param1];
         UnknownVarFromFurnitureParticleSystem_Boolean_1 = false;
         updateCanvas();
      }
      
      private function updateCanvas() : void
      {
         if(!UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1)
         {
            return;
         }
         if(UnknownVarFromFurnitureParticleSystem_Int_2 >= 0)
         {
            UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1 = _visualization.getSprite(UnknownVarFromFurnitureParticleSystem_Int_2);
            if(UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1 && UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.asset)
            {
               if(UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.width <= 1 || UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.height <= 1)
               {
                  return;
               }
               if(UnknownVarFromFurnitureParticleSystem_BitmapData_1 && (UnknownVarFromFurnitureParticleSystem_BitmapData_1.width != UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.width || UnknownVarFromFurnitureParticleSystem_BitmapData_1.height != UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.height))
               {
                  UnknownVarFromFurnitureParticleSystem_BitmapData_1 = null;
               }
               if(UnknownVarFromFurnitureParticleSystem_BitmapData_1 == null)
               {
                  UnknownVarFromFurnitureParticleSystem_BitmapData_1 = UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.asset.clone();
                  if(UnknownVarFromFurnitureParticleSystem_ColorTransform_1.alphaMultiplier != 1)
                  {
                     UnknownVarFromFurnitureParticleSystem_BitmapData_2 = new BitmapData(UnknownVarFromFurnitureParticleSystem_BitmapData_1.width,UnknownVarFromFurnitureParticleSystem_BitmapData_1.height,true,_bgColor);
                  }
               }
               UnknownVarFromFurnitureParticleSystem_Int_3 = -UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.offsetX;
               UnknownVarFromFurnitureParticleSystem_Int_4 = -UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.offsetY;
               UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.asset = UnknownVarFromFurnitureParticleSystem_BitmapData_1;
            }
            if(UnknownVarFromFurnitureParticleSystem_BitmapData_1)
            {
               UnknownVarFromFurnitureParticleSystem_BitmapData_1.fillRect(UnknownVarFromFurnitureParticleSystem_BitmapData_1.rect,_bgColor);
            }
            if(UnknownVarFromFurnitureParticleSystem_BitmapData_2)
            {
               UnknownVarFromFurnitureParticleSystem_BitmapData_2.fillRect(UnknownVarFromFurnitureParticleSystem_BitmapData_2.rect,_bgColor);
            }
         }
      }
      
      public function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1 && UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.roomObjectSpriteId == param3)
         {
            return UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.y * UnknownVarFromFurnitureParticleSystem_Number_1;
         }
         return 0;
      }
      
      public function controlsSprite(param1:int) : Boolean
      {
         if(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1)
         {
            return UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.roomObjectSpriteId == param1;
         }
         return false;
      }
      
      public function updateSprites() : void
      {
         if(!UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1 || !UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1)
         {
            return;
         }
         if(UnknownVarFromFurnitureParticleSystem_BitmapData_1 && UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.asset != UnknownVarFromFurnitureParticleSystem_BitmapData_1)
         {
            UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.asset = UnknownVarFromFurnitureParticleSystem_BitmapData_1;
            UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1.asset.width;
         }
         if(UnknownVarFromFurnitureParticleSystem_Boolean_1)
         {
            if(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.roomObjectSpriteId >= 0)
            {
               _visualization.getSprite(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.roomObjectSpriteId).visible = false;
            }
         }
      }
      
      public function updateAnimation() : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc1_:Rectangle = null;
         var _loc11_:IGraphicAsset = null;
         var _loc3_:BitmapData = null;
         var _loc6_:* = null;
         var _loc8_:Point = null;
         if(!UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1 || !UnknownVarFromFurnitureParticleSystem_IRoomObjectSprite_1)
         {
            return;
         }
         var _loc5_:Number = 10;
         var _loc4_:Number = 0;
         var _loc2_:int = 0;
         if(!UnknownVarFromFurnitureParticleSystem_Boolean_1 && UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.hasIgnited)
         {
            UnknownVarFromFurnitureParticleSystem_Boolean_1 = true;
         }
         _loc2_ = _offsetY * UnknownVarFromFurnitureParticleSystem_Number_1;
         UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.update();
         if(UnknownVarFromFurnitureParticleSystem_Boolean_1)
         {
            if(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.roomObjectSpriteId >= 0)
            {
               _visualization.getSprite(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.roomObjectSpriteId).visible = false;
            }
            if(!UnknownVarFromFurnitureParticleSystem_BitmapData_1)
            {
               updateCanvas();
            }
            UnknownVarFromFurnitureParticleSystem_BitmapData_1.lock();
            if(UnknownVarFromFurnitureParticleSystem_ColorTransform_1.alphaMultiplier == 1)
            {
               UnknownVarFromFurnitureParticleSystem_BitmapData_1.fillRect(UnknownVarFromFurnitureParticleSystem_BitmapData_1.rect,_bgColor);
            }
            else
            {
               UnknownVarFromFurnitureParticleSystem_BitmapData_1.draw(UnknownVarFromFurnitureParticleSystem_BitmapData_2,UnknownVarFromFurnitureParticleSystem_Matrix_1,UnknownVarFromFurnitureParticleSystem_ColorTransform_1,"normal",null,false);
            }
            for each(var _loc7_ in UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.particles)
            {
               _loc4_ = Number(_loc7_.y);
               _loc9_ = UnknownVarFromFurnitureParticleSystem_Int_3 + (_loc7_.x - _loc7_.z) * _loc5_ / 10 * UnknownVarFromFurnitureParticleSystem_Number_1;
               _loc10_ = UnknownVarFromFurnitureParticleSystem_Int_4 - _loc2_ + (_loc4_ + (_loc7_.x + _loc7_.z) / 2) * _loc5_ / 10 * UnknownVarFromFurnitureParticleSystem_Number_1;
               _loc11_ = _loc7_.getAsset();
               if(_loc11_)
               {
                  _loc3_ = _loc11_.asset.content as BitmapData;
                  if(_loc7_.fade && _loc7_.alphaMultiplier < 1)
                  {
                     UnknownVarFromFurnitureParticleSystem_Matrix_2.identity();
                     UnknownVarFromFurnitureParticleSystem_Matrix_2.translate(_loc9_ + _loc11_.offsetX,_loc10_ + _loc11_.offsetY);
                     UnknownVarFromFurnitureParticleSystem_ColorTransform_2.alphaMultiplier = _loc7_.alphaMultiplier;
                     UnknownVarFromFurnitureParticleSystem_BitmapData_1.draw(_loc3_,UnknownVarFromFurnitureParticleSystem_Matrix_2,UnknownVarFromFurnitureParticleSystem_ColorTransform_2,"normal",null,false);
                  }
                  else
                  {
                     _loc8_ = new Point(_loc9_ + _loc11_.offsetX,_loc10_ + _loc11_.offsetY);
                     UnknownVarFromFurnitureParticleSystem_BitmapData_1.copyPixels(_loc3_,_loc3_.rect,_loc8_,null,null,true);
                  }
               }
               else
               {
                  _loc1_ = new Rectangle(_loc9_ - 1,_loc10_ - 1,2,2);
                  UnknownVarFromFurnitureParticleSystem_BitmapData_1.fillRect(_loc1_,4294967295);
               }
            }
            UnknownVarFromFurnitureParticleSystem_BitmapData_1.unlock();
         }
      }
      
      public function parseData(param1:XML) : void
      {
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc21_:String = null;
         var _loc4_:int = 0;
         var _loc24_:FurnitureParticleSystemEmitter = null;
         var _loc19_:int = 0;
         var _loc14_:int = 0;
         var _loc25_:int = 0;
         var _loc18_:int = 0;
         var _loc22_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc15_:String = null;
         var _loc12_:Number = NaN;
         var _loc10_:int = 0;
         var _loc13_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc16_:Array = null;
         var _loc23_:IGraphicAsset = null;
         UnknownVarFromFurnitureParticleSystem_Int_1 = parseInt(param1.@size);
         UnknownVarFromFurnitureParticleSystem_Int_2 = !!param1.hasOwnProperty("@canvas_id") ? parseInt(param1.@canvas_id) : -1;
         _offsetY = !!param1.hasOwnProperty("@offset_y") ? parseInt(param1.@offset_y) : 10;
         UnknownVarFromFurnitureParticleSystem_Number_1 = UnknownVarFromFurnitureParticleSystem_Int_1 / 64;
         UnknownVarFromFurnitureParticleSystem_Number_2 = !!param1.hasOwnProperty("@blend") ? Number(param1.@blend) : 1;
         UnknownVarFromFurnitureParticleSystem_Number_2 = Math.min(UnknownVarFromFurnitureParticleSystem_Number_2,1);
         UnknownVarFromFurnitureParticleSystem_ColorTransform_1.alphaMultiplier = UnknownVarFromFurnitureParticleSystem_Number_2;
         var _loc8_:String = !!param1.hasOwnProperty("@bgcolor") ? String(param1.@bgcolor) : "0";
         _bgColor = !!param1.hasOwnProperty("@bgcolor") ? parseInt(_loc8_,16) : 4278190080;
         for each(var _loc6_ in param1.emitter)
         {
            _loc9_ = parseInt(_loc6_.@id);
            _loc21_ = _loc6_.@name;
            _loc4_ = parseInt(_loc6_.@sprite_id);
            _loc24_ = new FurnitureParticleSystemEmitter(_loc21_,_loc4_);
            _emitters[_loc9_] = _loc24_;
            _loc19_ = parseInt(_loc6_.@max_num_particles);
            _loc14_ = parseInt(_loc6_.@particles_per_frame);
            _loc25_ = !!_loc6_.hasOwnProperty("@burst_pulse") ? parseInt(_loc6_.@burst_pulse) : 1;
            _loc18_ = parseInt(_loc6_.@fuse_time);
            _loc22_ = Number(_loc6_.simulation.@force);
            _loc11_ = Number(_loc6_.simulation.@direction);
            _loc20_ = Number(_loc6_.simulation.@gravity);
            _loc3_ = Number(_loc6_.simulation.@airfriction);
            _loc15_ = _loc6_.simulation.@shape;
            _loc12_ = Number(_loc6_.simulation.@energy);
            for each(var _loc17_ in _loc6_.particles.particle)
            {
               _loc10_ = parseInt(_loc17_.@lifetime);
               _loc13_ = _loc17_.@is_emitter == "false" ? false : true;
               _loc5_ = _loc17_.hasOwnProperty("@fade") && _loc17_.@fade == "true" ? true : false;
               _loc16_ = [];
               for each(var _loc2_ in _loc17_.frame)
               {
                  _loc23_ = _visualization.assetCollection.getAsset(_loc2_.@name);
                  _loc16_.push(_loc23_);
               }
               _loc24_.configureParticle(_loc10_,_loc13_,_loc16_,_loc5_);
            }
            _loc24_.setup(_loc19_,_loc14_,_loc22_,new Vector3D(0,_loc11_,0),_loc20_,_loc3_,_loc15_,_loc12_,_loc18_,_loc25_);
         }
      }
      
      public function copyStateFrom(param1:FurnitureParticleSystem) : void
      {
         var _loc2_:int = 0;
         if(param1._emitters && param1.UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1)
         {
            _loc2_ = param1._emitters.getKey(param1._emitters.getValues().indexOf(param1.UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1));
         }
         setAnimation(_loc2_);
         if(UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1)
         {
            UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1.copyStateFrom(param1.UnknownVarFromFurnitureParticleSystem_FurnitureParticleSystemEmitter_1,param1.UnknownVarFromFurnitureParticleSystem_Int_1 / UnknownVarFromFurnitureParticleSystem_Int_1);
         }
         UnknownVarFromFurnitureParticleSystem_BitmapData_1 = null;
      }
   }
}


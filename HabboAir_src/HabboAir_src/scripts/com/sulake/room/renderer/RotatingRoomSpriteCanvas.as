package com.sulake.room.renderer
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.RoomRotatingEffect;
   import com.sulake.room.utils.RoomShakingEffect;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   [SecureSWF(rename="true")]
   public class RotatingRoomSpriteCanvas extends RoomSpriteCanvas
   {
      private var _tools:Sprite;
      
      private var UnknownVarFromRotatingRoomSpriteCanvas_Boolean_1:Boolean = false;
      
      private var UnknownVarFromRotatingRoomSpriteCanvas_Number_1:Number = 0;
      
      private var _rotationOrigin:Vector3d = null;
      
      private var _rotationRodLength:Number = 0;
      
      private var UnknownVarFromRotatingRoomSpriteCanvas_Array_1:Array = [];
      
      private var UnknownVarFromRotatingRoomSpriteCanvas_Array_2:Array = [];
      
      private var UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1:Vector3d;
      
      private var UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_2:Vector3d;
      
      private var UnknownVarFromRotatingRoomSpriteCanvas_Int_1:int = 0;
      
      public function RotatingRoomSpriteCanvas(param1:IRoomRenderer_1, param2:int, param3:int, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _tools = null;
         UnknownVarFromRotatingRoomSpriteCanvas_Array_1 = [];
         UnknownVarFromRotatingRoomSpriteCanvas_Array_2 = [];
      }
      
      override public function initialize(param1:int, param2:int) : void
      {
         super.initialize(param1,param2);
      }
      
      override public function render(param1:int, param2:Boolean = false) : void
      {
         doMagic();
         super.render(param1,param2);
      }
      
      override public function handleMouseEvent(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         var _loc8_:Boolean = super.handleMouseEvent(param1,param2,param3,param4,param5,param6,param7);
         if(param3 == "click")
         {
            checkButtonHits(param1 + screenOffsetX,param2 + screenOffsetY);
         }
         return _loc8_;
      }
      
      private function getGeometry() : RoomGeometry
      {
         return geometry as RoomGeometry;
      }
      
      private function doMagic() : void
      {
         var _loc2_:IVector3d = null;
         var _loc3_:Vector3d = null;
         var _loc4_:IVector3d = null;
         var _loc1_:Vector3d = null;
         if(UnknownVarFromRotatingRoomSpriteCanvas_Number_1 != 0)
         {
            _loc2_ = UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1;
            getGeometry().direction = new Vector3d(_loc2_.x + UnknownVarFromRotatingRoomSpriteCanvas_Number_1,_loc2_.y,_loc2_.z);
            _loc2_ = getGeometry().direction;
            getGeometry().setDepthVector(new Vector3d(_loc2_.x,_loc2_.y,5));
            _loc3_ = new Vector3d();
            _loc3_.assign(_rotationOrigin);
            _loc3_.x += _rotationRodLength * Math.cos((_loc2_.x + 180) / 180 * 3.141592653589793) * Math.cos(_loc2_.y / 180 * 3.141592653589793);
            _loc3_.y += _rotationRodLength * Math.sin((_loc2_.x + 180) / 180 * 3.141592653589793) * Math.cos(_loc2_.y / 180 * 3.141592653589793);
            _loc3_.z += _rotationRodLength * Math.sin(_loc2_.y / 180 * 3.141592653589793);
            getGeometry().location = _loc3_;
            UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_2 = new Vector3d();
            UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_2.assign(_loc3_);
            UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1 = new Vector3d();
            UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1.assign(getGeometry().direction);
         }
         if(RoomShakingEffect.isVisualizationOn() && !UnknownVarFromRotatingRoomSpriteCanvas_Boolean_1)
         {
            changeShaking();
         }
         else if(!RoomShakingEffect.isVisualizationOn() && UnknownVarFromRotatingRoomSpriteCanvas_Boolean_1)
         {
            changeShaking();
         }
         if(RoomRotatingEffect.isVisualizationOn())
         {
            changeRotation();
         }
         if(UnknownVarFromRotatingRoomSpriteCanvas_Boolean_1)
         {
            UnknownVarFromRotatingRoomSpriteCanvas_Int_1++;
            _loc4_ = UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1;
            _loc1_ = Vector3d.sum(_loc4_,new Vector3d(Math.sin(UnknownVarFromRotatingRoomSpriteCanvas_Int_1 * 5 / 180 * 3.141592653589793) * 2,Math.sin(UnknownVarFromRotatingRoomSpriteCanvas_Int_1 / 180 * 3.141592653589793) * 5,Math.sin(UnknownVarFromRotatingRoomSpriteCanvas_Int_1 * 10 / 180 * 3.141592653589793) * 2));
            getGeometry().direction = _loc1_;
         }
         else
         {
            UnknownVarFromRotatingRoomSpriteCanvas_Int_1 = 0;
            getGeometry().direction = UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1;
         }
      }
      
      private function createTestingTools() : void
      {
         var _loc4_:Array = null;
         var _loc1_:Rectangle = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_tools == null && displayObject is Sprite)
         {
            _tools = new Sprite();
            (displayObject as Sprite).addChild(_tools);
            _loc4_ = [16776960,16711680,65280,11184810,11184810,11184810,11184810];
            _loc1_ = null;
            _loc1_ = new Rectangle(58,8,16,16);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_1.push(_loc1_);
            _loc1_ = new Rectangle(58,28,16,16);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_1.push(_loc1_);
            _loc1_ = new Rectangle(58,48,16,16);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_1.push(_loc1_);
            _loc1_ = new Rectangle(82,28,16,16);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_1.push(_loc1_);
            _loc1_ = new Rectangle(122,28,16,16);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_1.push(_loc1_);
            _loc1_ = new Rectangle(102,8,16,16);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_1.push(_loc1_);
            _loc1_ = new Rectangle(102,48,16,16);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_1.push(_loc1_);
            _loc3_ = 0;
            while(_loc3_ < UnknownVarFromRotatingRoomSpriteCanvas_Array_1.length)
            {
               _loc1_ = UnknownVarFromRotatingRoomSpriteCanvas_Array_1[_loc3_] as Rectangle;
               _loc2_ = 0;
               _tools.graphics.beginFill(_loc2_);
               _tools.graphics.drawRect(_loc1_.x - 1,_loc1_.y - 1,_loc1_.width + 2,_loc1_.height + 2);
               _tools.graphics.endFill();
               _loc2_ = int(_loc4_[_loc3_]);
               _tools.graphics.beginFill(_loc2_);
               _tools.graphics.drawRect(_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height);
               _tools.graphics.endFill();
               _loc3_++;
            }
            UnknownVarFromRotatingRoomSpriteCanvas_Array_2.push(changeScale);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_2.push(changeShaking);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_2.push(changeRotation);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_2.push(moveLeft);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_2.push(moveRight);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_2.push(moveUp);
            UnknownVarFromRotatingRoomSpriteCanvas_Array_2.push(moveDown);
         }
      }
      
      private function checkButtonHits(param1:Number, param2:Number) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Rectangle = null;
         _loc4_ = 0;
         while(_loc4_ < UnknownVarFromRotatingRoomSpriteCanvas_Array_1.length)
         {
            _loc3_ = UnknownVarFromRotatingRoomSpriteCanvas_Array_1[_loc4_] as Rectangle;
            if(param1 >= _loc3_.x && param1 <= _loc3_.x + _loc3_.width && param2 >= _loc3_.y && param2 <= _loc3_.y + _loc3_.height)
            {
               if(UnknownVarFromRotatingRoomSpriteCanvas_Array_2.length > _loc4_)
               {
                  UnknownVarFromRotatingRoomSpriteCanvas_Array_2[_loc4_]();
               }
            }
            _loc4_++;
         }
      }
      
      private function changeScale() : void
      {
         if(getGeometry().scale < 64)
         {
            getGeometry().scale = 64;
         }
         else
         {
            getGeometry().scale = 32;
         }
      }
      
      private function changeShaking() : void
      {
         var _loc1_:IVector3d = null;
         UnknownVarFromRotatingRoomSpriteCanvas_Boolean_1 = !UnknownVarFromRotatingRoomSpriteCanvas_Boolean_1;
         if(UnknownVarFromRotatingRoomSpriteCanvas_Boolean_1)
         {
            _loc1_ = getGeometry().direction;
            UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1 = new Vector3d(_loc1_.x,_loc1_.y,_loc1_.z);
         }
      }
      
      private function changeRotation() : void
      {
         var _loc3_:IVector3d = null;
         var _loc1_:IVector3d = null;
         var _loc2_:IVector3d = null;
         if(UnknownVarFromRotatingRoomSpriteCanvas_Boolean_1)
         {
            return;
         }
         if(UnknownVarFromRotatingRoomSpriteCanvas_Number_1 == 0)
         {
            if(getGeometry() != null)
            {
               _loc3_ = getGeometry().location;
               _loc1_ = getGeometry().directionAxis;
               UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_2 = new Vector3d();
               UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_2.assign(_loc3_);
               UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1 = new Vector3d();
               UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1.assign(getGeometry().direction);
               _loc2_ = RoomGeometry.getIntersectionVector(_loc3_,_loc1_,new Vector3d(0,0,0),new Vector3d(0,0,1));
               if(_loc2_ != null)
               {
                  _rotationOrigin = new Vector3d(_loc2_.x,_loc2_.y,_loc2_.z);
                  _rotationRodLength = Vector3d.dif(_loc2_,_loc3_).length;
                  UnknownVarFromRotatingRoomSpriteCanvas_Number_1 = 1;
               }
            }
         }
         else
         {
            UnknownVarFromRotatingRoomSpriteCanvas_Number_1 = 0;
            if(getGeometry() != null)
            {
               getGeometry().location = UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_2;
               getGeometry().direction = UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1;
               getGeometry().setDepthVector(new Vector3d(UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1.x,UnknownVarFromRotatingRoomSpriteCanvas_Vector3d_1.y,5));
            }
         }
      }
      
      private function moveLeft() : void
      {
         var _loc1_:Number = NaN;
         if(UnknownVarFromRotatingRoomSpriteCanvas_Number_1 != 0)
         {
            if(UnknownVarFromRotatingRoomSpriteCanvas_Number_1 == 1)
            {
               UnknownVarFromRotatingRoomSpriteCanvas_Number_1 = -1;
            }
            else
            {
               UnknownVarFromRotatingRoomSpriteCanvas_Number_1 -= 1;
            }
            return;
         }
         if(getGeometry() != null)
         {
            _loc1_ = (getGeometry().direction.x - 90) / 180 * 3.141592653589793;
            getGeometry().location = Vector3d.sum(getGeometry().location,new Vector3d(Math.cos(_loc1_) * Math.sqrt(2),Math.sin(_loc1_) * Math.sqrt(2)));
         }
      }
      
      private function moveRight() : void
      {
         var _loc1_:Number = NaN;
         if(UnknownVarFromRotatingRoomSpriteCanvas_Number_1 != 0)
         {
            if(UnknownVarFromRotatingRoomSpriteCanvas_Number_1 == -1)
            {
               UnknownVarFromRotatingRoomSpriteCanvas_Number_1 = 1;
            }
            else
            {
               UnknownVarFromRotatingRoomSpriteCanvas_Number_1 += 1;
            }
            return;
         }
         if(getGeometry() != null)
         {
            _loc1_ = (getGeometry().direction.x + 90) / 180 * 3.141592653589793;
            getGeometry().location = Vector3d.sum(getGeometry().location,new Vector3d(Math.cos(_loc1_) * Math.sqrt(2),Math.sin(_loc1_) * Math.sqrt(2)));
         }
      }
      
      private function moveUp() : void
      {
         var _loc1_:Number = NaN;
         if(UnknownVarFromRotatingRoomSpriteCanvas_Number_1 != 0)
         {
            return;
         }
         if(getGeometry() != null)
         {
            _loc1_ = getGeometry().direction.x / 180 * 3.141592653589793;
            getGeometry().location = Vector3d.sum(getGeometry().location,new Vector3d(Math.cos(_loc1_) * Math.sqrt(2),Math.sin(_loc1_) * Math.sqrt(2)));
         }
      }
      
      private function moveDown() : void
      {
         var _loc1_:Number = NaN;
         if(UnknownVarFromRotatingRoomSpriteCanvas_Number_1 != 0)
         {
            return;
         }
         if(getGeometry() != null)
         {
            _loc1_ = (geometry.direction.x + 180) / 180 * 3.141592653589793;
            getGeometry().location = Vector3d.sum(getGeometry().location,new Vector3d(Math.cos(_loc1_) * Math.sqrt(2),Math.sin(_loc1_) * Math.sqrt(2)));
         }
      }
   }
}


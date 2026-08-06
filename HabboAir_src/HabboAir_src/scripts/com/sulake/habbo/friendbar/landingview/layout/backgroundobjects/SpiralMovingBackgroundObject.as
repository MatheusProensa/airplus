package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import flash.events.EventDispatcher;
   
   public class SpiralMovingBackgroundObject extends BackgroundObject
   {
      private var _startRadius:int;
      
      private var UnknownVarFromSpiralMovingBackgroundObject_Int_1:int;
      
      private var _posRadius:Number;
      
      private var UnknownVarFromSpiralMovingBackgroundObject_Number_1:Number;
      
      private var _speedRadius:Number;
      
      private var UnknownVarFromSpiralMovingBackgroundObject_Number_2:Number;
      
      private var UnknownVarFromSpiralMovingBackgroundObject_Number_3:Number;
      
      private var UnknownVarFromSpiralMovingBackgroundObject_Number_4:Number;
      
      public function SpiralMovingBackgroundObject(param1:int, param2:IWindowController_1, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         var _loc7_:Array = param5.split(";");
         var _loc6_:String = _loc7_[0];
         _startRadius = int(_loc7_[2]);
         UnknownVarFromSpiralMovingBackgroundObject_Int_1 = int(_loc7_[3]);
         _speedRadius = Number(_loc7_[4]);
         UnknownVarFromSpiralMovingBackgroundObject_Number_2 = Number(_loc7_[5]);
         UnknownVarFromSpiralMovingBackgroundObject_Number_3 = Number(_loc7_[6]);
         UnknownVarFromSpiralMovingBackgroundObject_Number_4 = Number(_loc7_[7]);
         _posRadius = _startRadius;
         UnknownVarFromSpiralMovingBackgroundObject_Number_1 = UnknownVarFromSpiralMovingBackgroundObject_Int_1;
         sprite.assetUri = "${image.library.url}reception/" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         var _loc2_:Number = _startRadius / _posRadius;
         var _loc3_:Number = 1 + _startRadius / _posRadius / 8;
         _posRadius += param1 * _speedRadius;
         UnknownVarFromSpiralMovingBackgroundObject_Number_1 += param1 * UnknownVarFromSpiralMovingBackgroundObject_Number_2 * _loc2_;
         if(sprite.bitmapData)
         {
            if(_posRadius <= 0)
            {
               _posRadius = _startRadius;
               sprite.width = sprite.bitmapData.width;
               sprite.height = sprite.bitmapData.height;
               events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
            }
         }
         if(_posRadius > _startRadius)
         {
            _posRadius = 0;
            sprite.width = 0;
            sprite.height = 0;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
         if(UnknownVarFromSpiralMovingBackgroundObject_Number_1 < 0)
         {
            UnknownVarFromSpiralMovingBackgroundObject_Number_1 = 3.141592653589793 * 2;
         }
         if(UnknownVarFromSpiralMovingBackgroundObject_Number_1 > 3.141592653589793 * 2)
         {
            UnknownVarFromSpiralMovingBackgroundObject_Number_1 = 0;
         }
         sprite.x = UnknownVarFromSpiralMovingBackgroundObject_Number_3 + Math.sin(UnknownVarFromSpiralMovingBackgroundObject_Number_1) * _posRadius;
         sprite.y = UnknownVarFromSpiralMovingBackgroundObject_Number_4 + Math.cos(UnknownVarFromSpiralMovingBackgroundObject_Number_1) * _posRadius;
         if(sprite.bitmapData)
         {
            sprite.pivotPoint = 4;
            sprite.stretchedX = true;
            sprite.stretchedY = true;
            sprite.width = sprite.bitmapData.width / _loc3_;
            sprite.height = sprite.bitmapData.height / _loc3_;
         }
      }
   }
}


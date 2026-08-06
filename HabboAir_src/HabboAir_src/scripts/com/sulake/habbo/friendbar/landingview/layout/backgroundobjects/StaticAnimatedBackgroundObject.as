package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import flash.events.EventDispatcher;
   
   public class StaticAnimatedBackgroundObject extends BackgroundObject
   {
      private var UnknownVarFromStaticAnimatedBackgroundObject_Uint_1:uint = 0;
      
      private var _imageBaseUri:String;
      
      private var UnknownVarFromStaticAnimatedBackgroundObject_Int_1:int;
      
      private var _fps:int;
      
      private var UnknownVarFromStaticAnimatedBackgroundObject_Int_2:int;
      
      private var UnknownVarFromStaticAnimatedBackgroundObject_Int_3:int;
      
      private var UnknownVarFromStaticAnimatedBackgroundObject_Array_1:Array;
      
      private var UnknownVarFromStaticAnimatedBackgroundObject_Uint_2:uint = 0;
      
      public function StaticAnimatedBackgroundObject(param1:int, param2:IWindowController_1, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         var _loc6_:Array = param5.split(";");
         _imageBaseUri = "${image.library.url}reception/" + _loc6_[0];
         UnknownVarFromStaticAnimatedBackgroundObject_Int_1 = int(_loc6_[2]);
         _fps = int(_loc6_[3]);
         UnknownVarFromStaticAnimatedBackgroundObject_Int_2 = int(_loc6_[4]);
         UnknownVarFromStaticAnimatedBackgroundObject_Int_3 = int(_loc6_[5]);
         UnknownVarFromStaticAnimatedBackgroundObject_Array_1 = String(_loc6_[6]).split(",");
         param3.addEventListener("LWMOPRE_MOVING_OBJECT_PATH_RESET",onPathResetEvent);
         sprite.x = UnknownVarFromStaticAnimatedBackgroundObject_Int_2;
         sprite.y = UnknownVarFromStaticAnimatedBackgroundObject_Int_3;
      }
      
      override public function dispose() : void
      {
         events.removeEventListener("LWMOPRE_MOVING_OBJECT_PATH_RESET",onPathResetEvent);
         super.dispose();
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         var _loc4_:int = 1000 / _fps;
         var _loc2_:uint = uint(UnknownVarFromStaticAnimatedBackgroundObject_Uint_1 - UnknownVarFromStaticAnimatedBackgroundObject_Uint_2);
         var _loc3_:int = UnknownVarFromStaticAnimatedBackgroundObject_Int_1 - 1;
         if(UnknownVarFromStaticAnimatedBackgroundObject_Array_1.length > 0)
         {
            if(_loc2_ < UnknownVarFromStaticAnimatedBackgroundObject_Int_1 * _loc4_)
            {
               _loc3_ = _loc2_ / _loc4_;
            }
         }
         else
         {
            _loc3_ = UnknownVarFromStaticAnimatedBackgroundObject_Uint_1 % _loc4_;
         }
         sprite.assetUri = _imageBaseUri + (_loc3_ + 1) + ".png";
         UnknownVarFromStaticAnimatedBackgroundObject_Uint_1 += param1;
      }
      
      private function onPathResetEvent(param1:PathResetEvent) : void
      {
         if(UnknownVarFromStaticAnimatedBackgroundObject_Array_1.indexOf(param1.objectId.toString()) != -1)
         {
            UnknownVarFromStaticAnimatedBackgroundObject_Uint_2 = UnknownVarFromStaticAnimatedBackgroundObject_Uint_1;
         }
      }
   }
}


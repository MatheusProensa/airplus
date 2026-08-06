package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class SnowWarAnimatedWindowElement implements IComponentInterfaceQueue
   {
      private var UnknownVarFromSnowWarAnimatedWindowElement_Int_1:int;
      
      private var UnknownVarFromSnowWarAnimatedWindowElement_String_1:String;
      
      private var _frames:Array;
      
      private var _currentFrame:int;
      
      private var UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromSnowWarAnimatedWindowElement_Timer_1:Timer;
      
      private var _disposed:Boolean = false;
      
      public function SnowWarAnimatedWindowElement(param1:IAssetLibraryCollection, param2:IBitmapWrapperController, param3:String, param4:int, param5:int = 100, param6:Boolean = false)
      {
         var _loc7_:int = 0;
         _frames = [];
         super();
         UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1 = param2;
         UnknownVarFromSnowWarAnimatedWindowElement_String_1 = param3;
         UnknownVarFromSnowWarAnimatedWindowElement_Int_1 = param4;
         _loc7_ = 1;
         while(_loc7_ <= UnknownVarFromSnowWarAnimatedWindowElement_Int_1)
         {
            if(param1.hasAsset(UnknownVarFromSnowWarAnimatedWindowElement_String_1 + _loc7_))
            {
               _frames.push(param1.getAssetByName(UnknownVarFromSnowWarAnimatedWindowElement_String_1 + _loc7_).content as BitmapData);
            }
            else
            {
               _frames.push(new BitmapData(1,1));
               Logger.log("Missing asset for Snow War: " + UnknownVarFromSnowWarAnimatedWindowElement_String_1 + _loc7_);
            }
            _loc7_++;
         }
         if(param6)
         {
            UnknownVarFromSnowWarAnimatedWindowElement_Int_1 += param4 - 2;
            _loc7_ = param4 - 1;
            while(_loc7_ > 1)
            {
               if(param1.hasAsset(UnknownVarFromSnowWarAnimatedWindowElement_String_1 + _loc7_))
               {
                  _frames.push(param1.getAssetByName(UnknownVarFromSnowWarAnimatedWindowElement_String_1 + _loc7_).content as BitmapData);
               }
               else
               {
                  _frames.push(new BitmapData(1,1));
                  Logger.log("Missing loop asset for Snow War: " + UnknownVarFromSnowWarAnimatedWindowElement_String_1 + _loc7_);
               }
               _loc7_--;
            }
         }
         update();
         UnknownVarFromSnowWarAnimatedWindowElement_Timer_1 = new Timer(param5);
         UnknownVarFromSnowWarAnimatedWindowElement_Timer_1.addEventListener("timer",onTimer);
         UnknownVarFromSnowWarAnimatedWindowElement_Timer_1.start();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromSnowWarAnimatedWindowElement_Timer_1.removeEventListener("timer",onTimer);
            UnknownVarFromSnowWarAnimatedWindowElement_Timer_1.stop();
            UnknownVarFromSnowWarAnimatedWindowElement_Timer_1 = null;
            if(UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1 && UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.bitmap)
            {
               UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.bitmap.fillRect(UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.bitmap.rect,0);
               UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.invalidate();
            }
            UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1 = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         _currentFrame = ++_currentFrame % UnknownVarFromSnowWarAnimatedWindowElement_Int_1;
         if(!UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.bitmap)
         {
            UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.width,UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.height);
         }
         UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.bitmap.fillRect(UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.bitmap.rect,0);
         var _loc2_:BitmapData = _frames[_currentFrame];
         var _loc1_:Point = new Point((UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.width - _loc2_.width) / 2,(UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.height - _loc2_.height) / 2);
         UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.bitmap.copyPixels(_loc2_,_loc2_.rect,_loc1_);
         UnknownVarFromSnowWarAnimatedWindowElement_IBitmapWrapperController_1.invalidate();
      }
   }
}


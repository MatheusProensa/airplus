package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import flash.display.BitmapData;
   
   public class Animation implements IComponentInterfaceQueue
   {
      private var UnknownVarFromAnimation_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromAnimation_Int_1:int;
      
      private var UnknownVarFromAnimation_Boolean_1:Boolean;
      
      private var _sprites:Array = [];
      
      public function Animation(param1:IBitmapWrapperController)
      {
         super();
         UnknownVarFromAnimation_IBitmapWrapperController_1 = param1;
         UnknownVarFromAnimation_IBitmapWrapperController_1.visible = false;
         if(param1.bitmap == null)
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
      }
      
      public function dispose() : void
      {
         UnknownVarFromAnimation_IBitmapWrapperController_1 = null;
         if(_sprites)
         {
            for each(var _loc1_ in _sprites)
            {
               _loc1_.dispose();
            }
            _sprites = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromAnimation_IBitmapWrapperController_1 == null;
      }
      
      public function addObject(param1:AnimationObject) : void
      {
         _sprites.push(param1);
      }
      
      public function stop() : void
      {
         UnknownVarFromAnimation_Boolean_1 = false;
         UnknownVarFromAnimation_IBitmapWrapperController_1.visible = false;
      }
      
      public function restart() : void
      {
         UnknownVarFromAnimation_Int_1 = 0;
         UnknownVarFromAnimation_Boolean_1 = true;
         for each(var _loc1_ in _sprites)
         {
            _loc1_.onAnimationStart();
         }
         draw();
         UnknownVarFromAnimation_IBitmapWrapperController_1.visible = true;
      }
      
      public function update(param1:uint) : void
      {
         if(UnknownVarFromAnimation_Boolean_1)
         {
            UnknownVarFromAnimation_Int_1 += param1;
            draw();
         }
      }
      
      private function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:BitmapData = null;
         UnknownVarFromAnimation_IBitmapWrapperController_1.bitmap.fillRect(UnknownVarFromAnimation_IBitmapWrapperController_1.bitmap.rect,0);
         if(UnknownVarFromAnimation_Boolean_1)
         {
            _loc1_ = false;
            for each(var _loc2_ in _sprites)
            {
               if(!_loc2_.isFinished(UnknownVarFromAnimation_Int_1))
               {
                  _loc1_ = true;
                  _loc3_ = _loc2_.getBitmap(UnknownVarFromAnimation_Int_1);
                  if(_loc3_ != null)
                  {
                     UnknownVarFromAnimation_IBitmapWrapperController_1.bitmap.copyPixels(_loc3_,_loc3_.rect,_loc2_.getPosition(UnknownVarFromAnimation_Int_1));
                  }
               }
            }
         }
         UnknownVarFromAnimation_IBitmapWrapperController_1.invalidate();
         UnknownVarFromAnimation_Boolean_1 = _loc1_;
      }
   }
}


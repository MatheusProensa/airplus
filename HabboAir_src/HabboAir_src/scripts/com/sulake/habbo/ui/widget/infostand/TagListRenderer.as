package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import flash.geom.Rectangle;
   
   public class TagListRenderer
   {
      private const MARGIN_X:int = 5;
      
      private const MARGIN_Y:int = 5;
      
      private var UnknownVarFromTagListRenderer_InfoStandWidget_1:InfoStandWidget;
      
      private var UnknownVarFromTagListRenderer_Function_1:Function;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var UnknownVarFromTagListRenderer_Rectangle_1:Rectangle = null;
      
      private var UnknownVarFromTagListRenderer_Int_1:int = 0;
      
      private var UnknownVarFromTagListRenderer_Array_1:Array;
      
      public function TagListRenderer(param1:InfoStandWidget, param2:Function)
      {
         super();
         UnknownVarFromTagListRenderer_InfoStandWidget_1 = param1;
         UnknownVarFromTagListRenderer_Function_1 = param2;
      }
      
      public function dispose() : void
      {
         UnknownVarFromTagListRenderer_InfoStandWidget_1 = null;
         UnknownVarFromTagListRenderer_Function_1 = null;
      }
      
      public function renderTags(param1:Array, param2:IWindowController_1, param3:Array) : int
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc9_:ITextWindow = null;
         var _loc7_:int = 0;
         UnknownVarFromTagListRenderer_Array_1 = param3;
         if(UnknownVarFromTagListRenderer_Array_1 != null)
         {
            _loc4_ = [];
            while(true)
            {
               _loc5_ = param1.pop();
               if(_loc5_ == null)
               {
                  break;
               }
               param3.indexOf(_loc5_) != -1 ? _loc4_.unshift(_loc5_) : uint(_loc4_.push(_loc5_));
            }
            param1 = _loc4_;
         }
         while(param2.removeChildAt(0) != null)
         {
         }
         UnknownVarFromTagListRenderer_Int_1 = 0;
         _offsetX = 0;
         _offsetY = 0;
         UnknownVarFromTagListRenderer_Rectangle_1 = param2.rectangle;
         UnknownVarFromTagListRenderer_Rectangle_1.height = 150;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc9_ = createTag(param1[_loc7_] as String);
            if(fit(_loc9_))
            {
               param2.addChild(_loc9_);
            }
            else
            {
               _loc9_.dispose();
            }
            _loc7_++;
         }
         var _loc8_:int = param2.numChildren;
         if(_loc8_ == 0)
         {
            return 0;
         }
         var _loc6_:IWindowModel = param2.getChildAt(param2.numChildren - 1);
         return _loc6_.bottom;
      }
      
      private function fit(param1:IWindowModel) : Boolean
      {
         if(param1.width > UnknownVarFromTagListRenderer_Rectangle_1.width)
         {
            return false;
         }
         if(_offsetY + param1.height > UnknownVarFromTagListRenderer_Rectangle_1.height)
         {
            return false;
         }
         if(_offsetX + param1.width > UnknownVarFromTagListRenderer_Rectangle_1.width)
         {
            _offsetX = 0;
            _offsetY += param1.height + 5;
            return fit(param1);
         }
         param1.offset(_offsetX,_offsetY);
         _offsetX += param1.width + 5;
         return true;
      }
      
      private function createTag(param1:String) : ITextWindow
      {
         var _loc2_:XmlAsset = null;
         if(UnknownVarFromTagListRenderer_Array_1 != null && UnknownVarFromTagListRenderer_Array_1.indexOf(param1) != -1)
         {
            _loc2_ = UnknownVarFromTagListRenderer_InfoStandWidget_1.assets.getAssetByName("user_tag_highlighted") as XmlAsset;
         }
         else
         {
            _loc2_ = UnknownVarFromTagListRenderer_InfoStandWidget_1.assets.getAssetByName("user_tag") as XmlAsset;
         }
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:ITextWindow = UnknownVarFromTagListRenderer_InfoStandWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as ITextWindow;
         if(_loc3_ == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _loc3_.addEventListener("WME_CLICK",UnknownVarFromTagListRenderer_Function_1);
         _loc3_.caption = param1;
         return _loc3_;
      }
   }
}


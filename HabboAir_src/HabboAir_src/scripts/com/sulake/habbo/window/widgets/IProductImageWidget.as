package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IProductImageWidget extends IWindowController_2
   {
      function set productInfo(param1:IProductDisplayInfo) : *;
      
      function get productInfo() : IProductDisplayInfo;
      
      function clearPreviewer() : void;
      
      function setPlaceholder() : void;
      
      function get pivot() : uint;
      
      function set pivot(param1:uint) : void;
      
      function set blend(param1:Number) : *;
      
      function get blend() : Number;
      
      function setUnknownImage() : void;
      
      function set unknownImageUri(param1:String) : void;
   }
}


package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.utils.UnknownICoreWindowUtils3;
   import flash.geom.Rectangle;
   
   public interface ISkinTemplateEntity extends UnknownICoreWindowUtils3
   {
      function get type() : String;
      
      function get region() : Rectangle;
   }
}


package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.window.utils.IChildEntityArray;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils3;
   
   public interface ISkinTemplate extends IChildEntityArray, UnknownICoreWindowUtils3
   {
      function get asset() : ISoundAsset;
      
      function dispose() : void;
   }
}


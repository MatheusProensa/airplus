package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public interface ISkinRenderer extends IComponentInterfaceQueue
   {
      function get name() : String;
      
      function parse(param1:ISoundAsset, param2:XMLList, param3:IAssetLibraryCollection) : void;
      
      function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void;
      
      function isStateDrawable(param1:uint) : Boolean;
      
      function addLayout(param1:ISkinLayout) : ISkinLayout;
      
      function getLayoutByName(param1:String) : ISkinLayout;
      
      function removeLayout(param1:ISkinLayout) : ISkinLayout;
      
      function getLayoutByState(param1:uint) : ISkinLayout;
      
      function registerLayoutForRenderState(param1:uint, param2:String) : void;
      
      function removeLayoutFromRenderState(param1:uint) : void;
      
      function hasLayoutForState(param1:uint) : Boolean;
      
      function addTemplate(param1:ISkinTemplate) : ISkinTemplate;
      
      function getTemplateByName(param1:String) : ISkinTemplate;
      
      function removeTemplate(param1:ISkinTemplate) : ISkinTemplate;
      
      function getTemplateByState(param1:uint) : ISkinTemplate;
      
      function registerTemplateForRenderState(param1:uint, param2:String) : void;
      
      function removeTemplateFromRenderState(param1:uint) : void;
      
      function hasTemplateForState(param1:uint) : Boolean;
   }
}


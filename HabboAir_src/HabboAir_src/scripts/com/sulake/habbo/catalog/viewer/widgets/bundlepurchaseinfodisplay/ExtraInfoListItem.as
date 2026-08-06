package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   
   public class ExtraInfoListItem implements IComponentInterfaceQueue
   {
      public static const ALIGN_TOP:int = 0;
      
      public static const ALIGN_BOTTOM:int = 1;
      
      public static const ALIGN_OVERLAY:int = 2;
      
      private var _id:int;
      
      private var _data:ExtraInfoItemData;
      
      private var _alignment:int;
      
      private var _alwaysOnTop:Boolean;
      
      private var _disposed:Boolean = false;
      
      private var _creationSeconds:Number;
      
      private var _removalSeconds:Number;
      
      private var _isItemRemoved:Boolean = false;
      
      public function ExtraInfoListItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:int = 0, param5:Boolean = false)
      {
         super();
         _id = param2;
         _data = param3;
         _alignment = param4;
         _alwaysOnTop = param5;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         _data = null;
         _disposed = true;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get data() : ExtraInfoItemData
      {
         return _data;
      }
      
      public function set data(param1:ExtraInfoItemData) : void
      {
         _data = param1;
      }
      
      public function get alignment() : int
      {
         return _alignment;
      }
      
      public function get alwaysOnTop() : Boolean
      {
         return _alwaysOnTop;
      }
      
      public function get creationSeconds() : Number
      {
         return _creationSeconds;
      }
      
      public function set creationSeconds(param1:Number) : void
      {
         _creationSeconds = param1;
      }
      
      public function get isItemRemoved() : Boolean
      {
         return _isItemRemoved;
      }
      
      public function get removalSeconds() : Number
      {
         return _removalSeconds;
      }
      
      public function set removalSeconds(param1:Number) : void
      {
         _removalSeconds = param1;
         _isItemRemoved = true;
      }
      
      public function getRenderedWindow() : IWindowController_1
      {
         return null;
      }
   }
}


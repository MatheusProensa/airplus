package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.utils.Map;
   import flash.display.BitmapData;
   
   public class HabboNotificationItemStyle
   {
      private var _icon:BitmapData;
      
      private var UnknownVarFromHabboNotificationItemStyle_Boolean_1:Boolean;
      
      private var _iconSrc:String;
      
      private var _internalLink:String;
      
      private var _iconAssetUri:String;
      
      private var _customLayout:String;
      
      private var _customView:String;
      
      private var _extraData:Object;
      
      private var _styleName:String;
      
      public function HabboNotificationItemStyle(param1:Map, param2:BitmapData, param3:String, param4:Boolean, param5:String, param6:Object, param7:String)
      {
         super();
         _iconAssetUri = param3;
         if(param1 != null && param3 == null)
         {
            _icon = param1["icon"];
            _internalLink = param1["internallink"];
            _customLayout = param1["customlayout"];
            _customView = param1["customview"];
         }
         if(param2 != null)
         {
            _icon = param2;
            UnknownVarFromHabboNotificationItemStyle_Boolean_1 = param4;
         }
         else
         {
            UnknownVarFromHabboNotificationItemStyle_Boolean_1 = false;
         }
         _iconSrc = param5;
         _extraData = param6;
         _styleName = param7;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromHabboNotificationItemStyle_Boolean_1 && _icon != null)
         {
            _icon.dispose();
            _icon = null;
         }
      }
      
      public function get icon() : BitmapData
      {
         return _icon;
      }
      
      public function get internalLink() : String
      {
         return _internalLink;
      }
      
      public function set internalLink(param1:String) : void
      {
         _internalLink = param1;
      }
      
      public function get iconSrc() : String
      {
         return _iconSrc;
      }
      
      public function get iconAssetUri() : String
      {
         return _iconAssetUri;
      }
      
      public function get customLayout() : String
      {
         return _customLayout;
      }
      
      public function get customView() : String
      {
         return _customView;
      }
      
      public function get extraData() : Object
      {
         return _extraData;
      }
      
      public function get styleName() : String
      {
         return _styleName;
      }
   }
}


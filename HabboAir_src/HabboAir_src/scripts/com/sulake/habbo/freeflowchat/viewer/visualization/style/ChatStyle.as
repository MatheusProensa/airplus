package com.sulake.habbo.freeflowchat.viewer.visualization.style
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.style.UnknownIHabboFreeflowchatStyle1;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   
   public class ChatStyle implements UnknownIHabboFreeflowchatStyle1, IChatStyle
   {
      private var _background:BitmapData;
      
      private var _scale9Grid:Rectangle;
      
      private var _pointer:BitmapData;
      
      private var _pointerY:int;
      
      private var _pointerXMargins:Array;
      
      private var _textFieldMargins:Rectangle;
      
      private var _textFormat:TextFormat;
      
      private var UnknownVarFromChatStyle_BitmapData_1:BitmapData;
      
      private var UnknownVarFromChatStyle_Point_1:Point;
      
      private var UnknownVarFromChatStyle_BitmapData_2:BitmapData;
      
      private var UnknownVarFromChatStyle_Point_2:Point;
      
      private var _iconImage:BitmapData;
      
      private var _faceOffset:Point;
      
      private var _selectorPreview:BitmapData;
      
      private var _color:BitmapData;
      
      private var UnknownVarFromChatStyle_Point_3:Point;
      
      private var _overlap:Rectangle;
      
      private var _isSystemStyle:Boolean;
      
      private var _purchasable:Boolean;
      
      private var _isHcOnly:Boolean;
      
      private var _isAmbassadorOnly:Boolean;
      
      private var _isStaffOverrideable:Boolean;
      
      private var _isAnonymous:Boolean;
      
      private var _allowHTML:Boolean;
      
      private var _styleSheet:StyleSheet;
      
      private var _isNotification:Boolean;
      
      private var _usePixelPerfectNineSlice:Boolean;
      
      public function ChatStyle(param1:BitmapData, param2:Rectangle, param3:BitmapData, param4:int, param5:Array, param6:Rectangle, param7:TextFormat, param8:Boolean, param9:BitmapData, param10:Point, param11:BitmapData, param12:Point, param13:Point, param14:BitmapData, param15:BitmapData, param16:Boolean, param17:Boolean, param18:Boolean, param19:Boolean, param20:Boolean, param21:Boolean, param22:BitmapData = null, param23:Point = null, param24:Rectangle = null, param25:Boolean = false, param26:StyleSheet = null, param27:Boolean = false)
      {
         super();
         _background = param1;
         _scale9Grid = param2;
         _pointer = param3;
         _pointerY = param4;
         _pointerXMargins = param5;
         _textFieldMargins = param6;
         _textFormat = param7;
         _isAnonymous = param8;
         UnknownVarFromChatStyle_BitmapData_1 = param9;
         UnknownVarFromChatStyle_Point_1 = param10;
         UnknownVarFromChatStyle_BitmapData_2 = param11;
         UnknownVarFromChatStyle_Point_2 = param12;
         _faceOffset = param13;
         _iconImage = param14;
         _selectorPreview = param15;
         _isSystemStyle = param16;
         _purchasable = param17;
         _isHcOnly = param18;
         _isAmbassadorOnly = param20;
         _isStaffOverrideable = param19;
         _color = param22;
         UnknownVarFromChatStyle_Point_3 = param23;
         _overlap = param24;
         _allowHTML = param25;
         _styleSheet = param26;
         _isNotification = param21;
         _usePixelPerfectNineSlice = param27;
      }
      
      public function getNewBackgroundSprite(param1:uint = 16777215) : Sprite
      {
         var _loc4_:BitmapData = null;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         if(_color != null)
         {
            _loc4_ = new BitmapData(_background.width,_background.height,_background.transparent,0);
            _loc4_.copyPixels(_background,_background.rect,new Point(0,0));
            _loc2_ = uint(param1 >> 16 & 0xFF);
            _loc5_ = uint(param1 >> 8 & 0xFF);
            _loc3_ = uint(param1 >> 0 & 0xFF);
            _loc4_.draw(_color,null,new ColorTransform(_loc2_ / 255,_loc5_ / 255,_loc3_ / 255),"darken");
         }
         else
         {
            _loc4_ = _background;
         }
         return _usePixelPerfectNineSlice ? HabboFreeFlowChat.createPixelPerfect9SliceSprite(_scale9Grid,_loc4_) : HabboFreeFlowChat.create9SliceSprite(_scale9Grid,_loc4_);
      }
      
      public function get textFormat() : TextFormat
      {
         return _textFormat;
      }
      
      public function get styleSheet() : StyleSheet
      {
         return _styleSheet;
      }
      
      public function get pointer() : BitmapData
      {
         return _pointer;
      }
      
      public function get pointerOffsetToBubbleBottom() : int
      {
         return _background.height - _pointerY;
      }
      
      public function getPointerLeftMargin(param1:int) : int
      {
         if(_pointerXMargins == null || _pointerXMargins.length < 1)
         {
            return param1;
         }
         return _pointerXMargins[0];
      }
      
      public function getPointerRightMargin(param1:int) : int
      {
         if(_pointerXMargins == null || _pointerXMargins.length < 2)
         {
            return param1;
         }
         return _pointerXMargins[1];
      }
      
      public function get isAnonymous() : Boolean
      {
         return _isAnonymous;
      }
      
      public function get faceOffset() : Point
      {
         return _faceOffset;
      }
      
      public function getEmblem(param1:Boolean = false) : BitmapData
      {
         if(param1 && UnknownVarFromChatStyle_BitmapData_2 != null && UnknownVarFromChatStyle_Point_2 != null)
         {
            return UnknownVarFromChatStyle_BitmapData_2;
         }
         return UnknownVarFromChatStyle_Point_1 != null ? UnknownVarFromChatStyle_BitmapData_1 : null;
      }
      
      public function getEmblemOffset(param1:Boolean = false) : Point
      {
         if(param1 && UnknownVarFromChatStyle_BitmapData_2 != null && UnknownVarFromChatStyle_Point_2 != null)
         {
            return UnknownVarFromChatStyle_Point_2;
         }
         return UnknownVarFromChatStyle_Point_1;
      }
      
      public function get iconImage() : BitmapData
      {
         return _iconImage;
      }
      
      public function get textFieldMargins() : Rectangle
      {
         return _textFieldMargins;
      }
      
      public function get overlap() : Rectangle
      {
         return _overlap;
      }
      
      public function get selectorPreview() : BitmapData
      {
         return _selectorPreview;
      }
      
      public function get isSystemStyle() : Boolean
      {
         return _isSystemStyle;
      }
      
      public function get purchasable() : Boolean
      {
         return _purchasable;
      }
      
      public function get isHcOnly() : Boolean
      {
         return _isHcOnly;
      }
      
      public function get isAmbassadorOnly() : Boolean
      {
         return _isAmbassadorOnly;
      }
      
      public function get isStaffOverrideable() : Boolean
      {
         return _isStaffOverrideable;
      }
      
      public function get allowHTML() : Boolean
      {
         return _allowHTML;
      }
      
      public function get isNotification() : Boolean
      {
         return _isNotification;
      }
   }
}


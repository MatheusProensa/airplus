package com.sulake.habbo.freeflowchat.viewer.visualization.style
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.freeflowchat.style.UnknownIHabboFreeflowchatStyle1;
   import com.sulake.habbo.freeflowchat.style.UnknownIHabboFreeflowchatStyle2;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   
   public class ChatStyleLibrary implements IComponentInterfaceQueue, UnknownIHabboFreeflowchatStyle2
   {
      private const DEFAULT_STYLE:int = 0;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _styles:Map;
      
      public function ChatStyleLibrary(param1:IAssetLibraryCollection)
      {
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc6_:* = false;
         var _loc2_:* = false;
         var _loc3_:* = false;
         var _loc5_:* = false;
         var _loc7_:* = false;
         var _loc12_:* = false;
         var _loc4_:* = false;
         var _loc10_:ChatStyle = null;
         _styles = new Map();
         super();
         _assets = param1;
         var _loc11_:XML = XML(_assets.getAssetByName("chatstyles_xml").content);
         for each(var _loc13_ in _loc11_.child("style"))
         {
            _loc8_ = int(_loc13_.@id[0]);
            _loc9_ = _loc13_.@assetId[0];
            _loc6_ = _loc13_.@systemStyle[0] == "true";
            _loc2_ = _loc13_.@purchasable[0] == "true";
            _loc3_ = _loc13_.@hcOnly[0] == "true";
            _loc5_ = _loc13_.@staffOverrideable[0] == "true";
            _loc7_ = _loc13_.@allowHTML[0] == "true";
            _loc12_ = _loc13_.@ambassadorOnly[0] == "true";
            _loc4_ = _loc13_.@notification[0] == "true";
            try
            {
               _loc10_ = initializeStyleFromAssets(_loc9_,_loc6_,_loc2_,_loc3_,_loc5_,_loc7_,_loc12_,_loc4_);
               _styles.add(_loc8_,_loc10_);
            }
            catch(e:Error)
            {
               Logger.log("Error initializing chat style: " + _loc8_ + ", error message: " + e.message);
            }
         }
      }
      
      public function dispose() : void
      {
         _styles.dispose();
         _styles = null;
         _assets = null;
      }
      
      public function get disposed() : Boolean
      {
         return _assets == null;
      }
      
      private function initializeStyleFromAssets(param1:String, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : ChatStyle
      {
         var _loc20_:BitmapData = null;
         var _loc37_:String = String(_assets.getAssetByName("style_" + param1 + "_regpoints").content);
         var _loc38_:BitmapData = _assets.getAssetByName("style_" + param1 + "_chat_bubble_base").content as BitmapData;
         var _loc28_:Rectangle = new Rectangle(getConfigPoint(_loc37_,"9sliceXY").x,getConfigPoint(_loc37_,"9sliceXY").y,getConfigPoint(_loc37_,"9sliceWH").x,getConfigPoint(_loc37_,"9sliceWH").y);
         var _loc22_:Point = hasConfig(_loc37_,"faceXY") ? getConfigPoint(_loc37_,"faceXY") : null;
         var _loc32_:int = 0;
         var _loc33_:Array = null;
         var _loc30_:Boolean = hasConfig(_loc37_,"anonymous") ? getConfigBoolean(_loc37_,"anonymous") : false;
         if(!_loc30_)
         {
            _loc20_ = _assets.getAssetByName("style_" + param1 + "_chat_bubble_pointer").content as BitmapData;
            _loc32_ = int(getConfigCSV(_loc37_,"pointerY")[0]);
            _loc33_ = hasConfig(_loc37_,"pointerXMargins") ? getConfigIntArray(_loc37_,"pointerXMargins") : null;
         }
         var _loc18_:BitmapData = null;
         var _loc19_:Point = null;
         if(hasConfig(_loc37_,"emblemXY") && _assets.hasAsset("style_" + param1 + "_chat_bubble_emblem"))
         {
            _loc18_ = _assets.getAssetByName("style_" + param1 + "_chat_bubble_emblem").content as BitmapData;
            _loc19_ = getConfigPoint(_loc37_,"emblemXY");
         }
         var _loc12_:BitmapData = null;
         var _loc23_:Point = null;
         if(hasConfig(_loc37_,"emblemMultilineXY") && _assets.hasAsset("style_" + param1 + "_chat_bubble_emblem_multiline"))
         {
            _loc12_ = _assets.getAssetByName("style_" + param1 + "_chat_bubble_emblem_multiline").content as BitmapData;
            _loc23_ = getConfigPoint(_loc37_,"emblemMultilineXY");
         }
         var _loc9_:BitmapData = _assets.hasAsset("style_" + param1 + "_icon") ? _assets.getAssetByName("style_" + param1 + "_icon").content as BitmapData : null;
         var _loc17_:Rectangle = getConfigRect(_loc37_,"textFieldMargins");
         var _loc31_:BitmapData = _assets.getAssetByName("style_" + param1 + "_selector_preview").content as BitmapData;
         var _loc10_:BitmapData = null;
         if(_assets.hasAsset("style_" + param1 + "_chat_bubble_color"))
         {
            _loc10_ = _assets.getAssetByName("style_" + param1 + "_chat_bubble_color").content as BitmapData;
         }
         var _loc36_:Point = hasConfig(_loc37_,"colorXY") ? getConfigPoint(_loc37_,"colorXY") : null;
         var _loc15_:Rectangle = hasConfig(_loc37_,"overlapRect") ? getConfigRect(_loc37_,"overlapRect") : null;
         var _loc27_:uint = uint(hasConfig(_loc37_,"textColorRGB") ? uint(getConfigCSV(_loc37_,"textColorRGB")[0]) : 0);
         var _loc13_:String = hasConfig(_loc37_,"fontFace") ? getConfigCSV(_loc37_,"fontFace")[0] : "Volter";
         var _loc34_:int = int(hasConfig(_loc37_,"fontSize") ? int(getConfigCSV(_loc37_,"fontSize")[0]) : 9);
         var _loc29_:TextFormat = new TextFormat(_loc13_,_loc34_,_loc27_);
         var _loc25_:uint = hasConfig(_loc37_,"linkColorRGB") ? uint(getConfigCSV(_loc37_,"linkColorRGB")[0]) : _loc27_;
         var _loc35_:uint = hasConfig(_loc37_,"linkHoverColorRGB") ? uint(getConfigCSV(_loc37_,"linkHoverColorRGB")[0]) : _loc27_;
         var _loc26_:uint = hasConfig(_loc37_,"linkActiveColorRGB") ? uint(getConfigCSV(_loc37_,"linkActiveColorRGB")[0]) : _loc27_;
         var _loc11_:StyleSheet = new StyleSheet();
         var _loc14_:Object = {};
         _loc14_.textDecoration = "underline";
         _loc14_.color = toHexString(_loc25_);
         _loc11_.setStyle("a:link",_loc14_);
         var _loc24_:Object = {};
         _loc24_.color = toHexString(_loc26_);
         _loc11_.setStyle("a:active",_loc24_);
         var _loc16_:Object = {};
         _loc16_.color = toHexString(_loc35_);
         _loc11_.setStyle("a:hover",_loc16_);
         var _loc21_:Boolean = hasConfig(_loc37_,"usePixelPerfectNineSlice") ? getConfigBoolean(_loc37_,"usePixelPerfectNineSlice") : false;
         return new ChatStyle(_loc38_,_loc28_,_loc20_,_loc32_,_loc33_,_loc17_,_loc29_,_loc30_,_loc18_,_loc19_,_loc12_,_loc23_,_loc22_,_loc9_,_loc31_,param2,param3,param4,param5,param7,param8,_loc10_,_loc36_,_loc15_,param6,_loc11_,_loc21_);
      }
      
      private function toHexString(param1:uint) : String
      {
         var _loc2_:String = param1.toString(16);
         while(_loc2_.length < 6)
         {
            _loc2_ = "0" + _loc2_;
         }
         return "#" + _loc2_;
      }
      
      private function hasConfig(param1:String, param2:String) : Boolean
      {
         return param1.indexOf(param2) != -1;
      }
      
      private function getConfigCSV(param1:String, param2:String) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = false;
         var _loc7_:String = null;
         var _loc4_:int = int(param1.indexOf(param2));
         if(_loc4_ != -1)
         {
            _loc5_ = int(param1.indexOf("=",_loc4_));
            _loc6_ = int(param1.indexOf("\r\n",_loc5_));
            if(_loc6_ == -1)
            {
               _loc6_ = int(param1.indexOf("\n",_loc5_));
            }
            if(_loc6_ == -1)
            {
               _loc6_ = param1.length;
            }
            _loc3_ = param1.charAt(_loc5_ + 1) == " ";
            _loc7_ = param1.substr(_loc5_ + (_loc3_ ? 2 : 1),_loc6_ - _loc5_ - (_loc3_ ? 2 : 1));
            return _loc7_.split(",");
         }
         return null;
      }
      
      private function getConfigPoint(param1:String, param2:String) : Point
      {
         return new Point(int(getConfigCSV(param1,param2)[0]),int(getConfigCSV(param1,param2)[1]));
      }
      
      private function getConfigIntArray(param1:String, param2:String) : Array
      {
         var _loc4_:Array = getConfigCSV(param1,param2);
         var _loc3_:Array = [];
         for each(var _loc5_ in _loc4_)
         {
            _loc3_.push(_loc5_);
         }
         return _loc3_;
      }
      
      private function getConfigRect(param1:String, param2:String) : Rectangle
      {
         return new Rectangle(int(getConfigCSV(param1,param2)[0]),int(getConfigCSV(param1,param2)[1]),int(getConfigCSV(param1,param2)[2]),int(getConfigCSV(param1,param2)[3]));
      }
      
      private function getConfigBoolean(param1:String, param2:String) : Boolean
      {
         return getConfigCSV(param1,param2)[0] == "true";
      }
      
      public function getStyleIds() : Array
      {
         return _styles.getKeys();
      }
      
      public function getStyle(param1:int) : UnknownIHabboFreeflowchatStyle1
      {
         if(_styles.hasKey(param1))
         {
            return _styles.getValue(param1);
         }
         return _styles.getValue(0);
      }
   }
}


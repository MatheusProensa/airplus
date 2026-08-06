package com.sulake.habbo.freeflowchat.history.visualization.entry
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.history.visualization.enum.UnknownHabboFreeflowchatHistoryVisualizationEnum1;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class ChatHistoryEntryBitmapBubble implements IChatHistoryEntryBitmapBubble
   {
      private var _bitmap:BitmapData;
      
      private var _overlap:Rectangle;
      
      private var _userIndex:int;
      
      private var _webId:int;
      
      private var _roomId:int;
      
      private var _canIgnore:Boolean;
      
      private var _userName:String;
      
      public function ChatHistoryEntryBitmapBubble(param1:ChatItem, param2:Boolean, param3:int, param4:String, param5:BitmapData, param6:Rectangle = null)
      {
         super();
         _overlap = param6;
         _userIndex = param1.userId;
         _webId = param3;
         _roomId = param1.roomId;
         var _loc7_:TextField = new TextField();
         _loc7_.defaultTextFormat = UnknownHabboFreeflowchatHistoryVisualizationEnum1.TEXT_FORMAT_TIMESTAMP;
         _loc7_.text = HabboFreeFlowChat.getTimeStampNow();
         _loc7_.thickness = -15;
         _loc7_.sharpness = 80;
         _loc7_.antiAliasType = "advanced";
         _loc7_.embedFonts = true;
         _loc7_.gridFitType = "pixel";
         var _loc9_:int = param5.height;
         var _loc8_:int = 62;
         var _loc10_:int = Math.max(3,3 + param6.top);
         _bitmap = new BitmapData(_loc8_ + param5.width,_loc9_,true,0);
         _bitmap.draw(_loc7_,new Matrix(1,0,0,1,0,_loc10_));
         _bitmap.copyPixels(param5,param5.rect,new Point(_loc8_,0));
         _canIgnore = param2;
         _userName = param4;
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmap;
      }
      
      public function get overlap() : Rectangle
      {
         return _overlap;
      }
      
      public function get userIndex() : int
      {
         return _userIndex;
      }
      
      public function get webId() : int
      {
         return _webId;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get canIgnore() : Boolean
      {
         return _canIgnore;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}


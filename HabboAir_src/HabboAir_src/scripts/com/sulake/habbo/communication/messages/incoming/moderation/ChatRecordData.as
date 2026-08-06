package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class ChatRecordData
   {
      public static const UnknownConstFromChatRecordData_Int_1:int = 0;
      
      public static const UnknownConstFromChatRecordData_Int_2:int = 1;
      
      public static const UnknownConstFromChatRecordData_Int_3:int = 2;
      
      public static const UnknownConstFromChatRecordData_Int_4:int = 3;
      
      public static const UnknownConstFromChatRecordData_Int_5:int = 4;
      
      public static const TYPE_SELFIE:int = 5;
      
      public static const UnknownConstFromChatRecordData_Int_6:int = 6;
      
      private var _recordType:int;
      
      private var _context:Dictionary;
      
      private var _chatlog:Array;
      
      public function ChatRecordData(param1:IMessageDataWrapper)
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _context = new Dictionary();
         _chatlog = [];
         super();
         _recordType = param1.readByte();
         var _loc2_:int = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1.readString();
            switch(_loc6_ = param1.readByte())
            {
               case 0:
                  _context[_loc3_] = param1.readBoolean();
                  break;
               case 1:
                  _context[_loc3_] = param1.readInteger();
                  break;
               case 2:
                  _context[_loc3_] = param1.readString();
                  break;
               default:
                  throw new Error("Unknown data type " + _loc6_);
            }
            _loc4_++;
         }
         var _loc7_:int = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _chatlog.push(new ChatlineData(param1));
            _loc5_++;
         }
      }
      
      public function get recordType() : int
      {
         return _recordType;
      }
      
      public function get context() : Dictionary
      {
         return _context;
      }
      
      public function get chatlog() : Array
      {
         return _chatlog;
      }
      
      public function get roomId() : int
      {
         return getInt("roomId");
      }
      
      public function get roomName() : String
      {
         return _context["roomName"] as String;
      }
      
      public function get groupId() : int
      {
         return getInt("groupId");
      }
      
      public function get threadId() : int
      {
         return getInt("threadId");
      }
      
      public function get messageId() : int
      {
         return getInt("messageId");
      }
      
      private function getInt(param1:String) : int
      {
         var _loc2_:* = _context[param1];
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_ as int;
      }
   }
}


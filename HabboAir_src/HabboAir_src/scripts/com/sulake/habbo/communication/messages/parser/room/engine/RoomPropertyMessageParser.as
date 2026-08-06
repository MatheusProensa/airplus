package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomPropertyMessageParser implements IMessageParser
   {
      private var _floorType:String = null;
      
      private var _wallType:String = null;
      
      private var _landscapeType:String = null;
      
      private var _animatedLandscapeType:String = null;
      
      public function RoomPropertyMessageParser()
      {
         super();
      }
      
      public function get floorType() : String
      {
         return _floorType;
      }
      
      public function get wallType() : String
      {
         return _wallType;
      }
      
      public function get landscapeType() : String
      {
         return _landscapeType;
      }
      
      public function get animatedLandscapeType() : String
      {
         return _animatedLandscapeType;
      }
      
      public function flush() : Boolean
      {
         _floorType = null;
         _wallType = null;
         _landscapeType = null;
         _animatedLandscapeType = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:String = param1.readString();
         var _loc2_:String = param1.readString();
         switch(_loc3_)
         {
            case "floor":
               _floorType = _loc2_;
               break;
            case "wallpaper":
               _wallType = _loc2_;
               break;
            case "landscape":
               _landscapeType = _loc2_;
               break;
            case "landscapeanim":
               _animatedLandscapeType = _loc2_;
         }
         return true;
      }
   }
}


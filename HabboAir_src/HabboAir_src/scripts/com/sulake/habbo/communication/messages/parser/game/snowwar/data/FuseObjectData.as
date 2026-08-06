package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.parser.room.engine.UnknownHabboCommunicationMessagesParserRoomEngine1;
   import com.sulake.habbo.room.IStuffData;
   
   public class FuseObjectData
   {
      private var _name:String;
      
      private var _id:int;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _xDimension:int;
      
      private var _yDimension:int;
      
      private var _height:int;
      
      private var _direction:int;
      
      private var _altitude:int;
      
      private var _canStandOn:Boolean;
      
      private var _stuffData:IStuffData;
      
      public function FuseObjectData()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         _name = param1.readString();
         _id = param1.readInteger();
         _x = param1.readInteger();
         _y = param1.readInteger();
         _xDimension = param1.readInteger();
         _yDimension = param1.readInteger();
         _height = param1.readInteger();
         _direction = param1.readInteger();
         _altitude = param1.readInteger();
         _canStandOn = param1.readBoolean();
         _stuffData = UnknownHabboCommunicationMessagesParserRoomEngine1.parseStuffData(param1);
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get xDimension() : int
      {
         return _xDimension;
      }
      
      public function get yDimension() : int
      {
         return _yDimension;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function get altitude() : int
      {
         return _altitude;
      }
      
      public function get canStandOn() : Boolean
      {
         return _canStandOn;
      }
      
      public function get stuffData() : IStuffData
      {
         return _stuffData;
      }
   }
}


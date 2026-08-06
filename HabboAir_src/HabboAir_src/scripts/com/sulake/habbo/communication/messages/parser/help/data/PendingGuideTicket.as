package com.sulake.habbo.communication.messages.parser.help.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class PendingGuideTicket
   {
      private var _type:int;
      
      private var _secondsAgo:int;
      
      private var _isGuide:Boolean;
      
      private var _otherPartyName:String;
      
      private var _otherPartyFigure:String;
      
      private var _description:String;
      
      private var _roomName:String;
      
      public function PendingGuideTicket(param1:IMessageDataWrapper)
      {
         super();
         _type = param1.readInteger();
         _secondsAgo = param1.readInteger();
         _isGuide = param1.readBoolean();
         switch(_type)
         {
            case 0:
            case 2:
               _otherPartyName = param1.readString();
               _otherPartyFigure = param1.readString();
               return;
            case 1:
               _otherPartyName = param1.readString();
               _otherPartyFigure = param1.readString();
               _description = param1.readString();
               return;
            case 3:
               if(!isGuide)
               {
                  _otherPartyName = param1.readString();
                  _otherPartyFigure = param1.readString();
                  _roomName = param1.readString();
               }
               return;
            default:
               return;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get secondsAgo() : int
      {
         return _secondsAgo;
      }
      
      public function get isGuide() : Boolean
      {
         return _isGuide;
      }
      
      public function get otherPartyName() : String
      {
         return _otherPartyName;
      }
      
      public function get otherPartyFigure() : String
      {
         return _otherPartyFigure;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
   }
}


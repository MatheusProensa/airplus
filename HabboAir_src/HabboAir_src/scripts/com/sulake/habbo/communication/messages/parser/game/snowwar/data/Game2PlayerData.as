package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public class Game2PlayerData implements IComponentInterfaceQueue
   {
      private var _referenceId:int;
      
      private var _userName:String;
      
      private var _figureString:String;
      
      private var _gender:String;
      
      private var _teamId:int;
      
      private var _disposed:Boolean = false;
      
      public function Game2PlayerData()
      {
         super();
      }
      
      public function dispose() : void
      {
         _userName = null;
         _figureString = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         _referenceId = param1.readInteger();
         _userName = param1.readString();
         _figureString = param1.readString();
         _gender = param1.readString();
         _teamId = param1.readInteger();
      }
      
      public function toString() : String
      {
         return "[Game Player] " + _referenceId + ": " + _userName;
      }
      
      public function get referenceId() : int
      {
         return _referenceId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get teamId() : int
      {
         return _teamId;
      }
      
      public function get isDisposed() : Boolean
      {
         return _disposed;
      }
   }
}


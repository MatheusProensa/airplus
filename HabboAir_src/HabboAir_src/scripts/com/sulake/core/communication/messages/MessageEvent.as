package com.sulake.core.communication.messages
{
   import com.sulake.core.communication.connection.IConnection;
   
   public class MessageEvent implements IMessageEvent
   {
      protected var _callback:Function;
      
      protected var _connection:IConnection;
      
      private var _parserClass:Class;
      
      protected var _parser:IMessageParser;
      
      public function MessageEvent(param1:Function, param2:Class)
      {
         super();
         _callback = param1;
         _parserClass = param2;
      }
      
      public function dispose() : void
      {
         _callback = null;
         _parserClass = null;
         _connection = null;
         _parser = null;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function set connection(param1:IConnection) : void
      {
         _connection = param1;
      }
      
      public function get connection() : IConnection
      {
         return _connection;
      }
      
      public function get parserClass() : Class
      {
         return _parserClass;
      }
      
      public function get parser() : IMessageParser
      {
         return _parser;
      }
      
      public function set parser(param1:IMessageParser) : void
      {
         _parser = param1;
      }
   }
}


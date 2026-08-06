package com.sulake.core.communication
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.connection.UnknownICoreCommunicationConnection1;
   import com.sulake.core.runtime.IUnknown;
   
   public interface ICoreCommunicationManager extends IUnknown
   {
      function createConnection(param1:UnknownICoreCommunicationConnection1 = null) : IConnection;
   }
}


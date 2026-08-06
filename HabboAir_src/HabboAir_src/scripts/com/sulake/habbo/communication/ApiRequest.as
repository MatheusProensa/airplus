package com.sulake.habbo.communication
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ApiRequest
   {
      public static const ERROR_TYPE_INVALID_CAPTCHA:String = "invalid-captcha";
      
      private var UnknownVarFromApiRequest_IHabboWebApiSession_2_1:IHabboWebApiSession_2;
      
      private var UnknownVarFromApiRequest_URLRequest_1:URLRequest;
      
      private var _uri:String;
      
      private var _requestMethod:String;
      
      private var _currentStatus:int;
      
      public function ApiRequest(param1:String, param2:String)
      {
         super();
         _uri = param2;
         _requestMethod = param1;
      }
      
      public function get uri() : String
      {
         return _uri;
      }
      
      public function get requestMethod() : String
      {
         return _requestMethod;
      }
      
      public function dispose() : void
      {
         UnknownVarFromApiRequest_IHabboWebApiSession_2_1 = null;
         UnknownVarFromApiRequest_URLRequest_1 = null;
         _uri = null;
         _requestMethod = null;
         _currentStatus = 0;
      }
      
      public function makeRequest(param1:IHabboWebApiSession_2, param2:URLRequest) : void
      {
         param2.method = _requestMethod;
         UnknownVarFromApiRequest_URLRequest_1 = param2;
         UnknownVarFromApiRequest_IHabboWebApiSession_2_1 = param1;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.dataFormat = "text";
         configureListeners(_loc3_);
         try
         {
            Logger.log("[ApiRequest] Make request: " + param2.url + " for " + _uri);
            _loc3_.load(param2);
         }
         catch(error:Error)
         {
            Logger.log("[ApiRequest] Unable to load requested document.");
         }
      }
      
      private function configureListeners(param1:IEventDispatcher) : void
      {
         param1.addEventListener("complete",completeHandler);
         param1.addEventListener("open",openHandler);
         param1.addEventListener("progress",progressHandler);
         param1.addEventListener("securityError",securityErrorHandler);
         param1.addEventListener("httpStatus",httpStatusHandler);
         param1.addEventListener("ioError",ioErrorHandler);
      }
      
      private function removeListeners(param1:IEventDispatcher) : void
      {
         param1.removeEventListener("complete",completeHandler);
         param1.removeEventListener("open",openHandler);
         param1.removeEventListener("progress",progressHandler);
         param1.removeEventListener("securityError",securityErrorHandler);
         param1.removeEventListener("httpStatus",httpStatusHandler);
         param1.removeEventListener("ioError",ioErrorHandler);
      }
      
      private function completeHandler(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Object = null;
         var _loc7_:Boolean = false;
         var _loc4_:URLLoader = URLLoader(param1.target);
         removeListeners(_loc4_);
         if(UnknownVarFromApiRequest_IHabboWebApiSession_2_1)
         {
            _loc5_ = _loc4_.data as String;
            _loc6_ = _loc5_ && (_loc5_.charAt(0) == "{" || _loc5_.charAt(0) == "[");
            _loc2_ = _loc5_ && _loc5_.charAt(0) == "<";
            try
            {
               if(_loc6_)
               {
                  _loc3_ = JSON.parse(_loc5_);
               }
               else if(_loc2_)
               {
                  _loc3_ = new XML(_loc5_);
               }
               if(_currentStatus >= 400 || _loc6_ && _loc3_.error != null)
               {
                  _loc7_ = false;
                  if(_loc6_)
                  {
                     _loc7_ = _loc3_.error == "invalid-captcha" || _loc3_.message == "invalid-captcha";
                  }
                  UnknownVarFromApiRequest_IHabboWebApiSession_2_1.apiError(_uri,_currentStatus,_loc6_ ? _loc3_.error : "",_loc3_,_loc7_);
               }
               else
               {
                  UnknownVarFromApiRequest_IHabboWebApiSession_2_1.apiResponse(_uri,_loc3_);
               }
            }
            catch(e:Error)
            {
               Logger.log("JSON parsing for API Request message failed. Data: " + _loc4_.data + " Error: " + e.errorID,e.name,e.message,e.getStackTrace());
               UnknownVarFromApiRequest_IHabboWebApiSession_2_1.apiRawResponse(_uri,_loc4_.data);
            }
         }
      }
      
      private function openHandler(param1:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
      }
      
      private function progressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         Logger.log("[ApiRequest] securityErrorHandler: " + param1);
         if(UnknownVarFromApiRequest_IHabboWebApiSession_2_1 != null)
         {
            UnknownVarFromApiRequest_IHabboWebApiSession_2_1.apiError(_uri,-1,"securityError",null);
         }
         removeListeners(_loc2_);
      }
      
      private function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         _currentStatus = param1.status;
         switch(param1.status)
         {
            case 200:
            case 403:
               break;
            case 404:
               Logger.log("[ApiRequest - 404] httpStatusHandler: Resource does not exist. " + _uri,_requestMethod,UnknownVarFromApiRequest_URLRequest_1.url);
               break;
            case 409:
               Logger.log("[ApiRequest - 409] httpStatusHandler: Conflict. " + _uri,_requestMethod,UnknownVarFromApiRequest_URLRequest_1.url,_loc2_);
               break;
            case 500:
               Logger.log("[ApiRequest - 500] httpStatusHandler: Internal server error. " + _uri,_requestMethod,_loc2_);
               break;
            default:
               Logger.log("[ApiRequest - " + param1.status + "] httpStatusHandler: undhandled. " + _uri,_requestMethod,UnknownVarFromApiRequest_URLRequest_1.url);
         }
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Boolean = false;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc5_:URLLoader = URLLoader(param1.target);
         removeListeners(_loc5_);
         if(UnknownVarFromApiRequest_IHabboWebApiSession_2_1 != null)
         {
            _loc3_ = {"message":_loc5_.data};
            _loc4_ = false;
            if(_loc5_.data)
            {
               try
               {
                  _loc6_ = _loc5_.data;
                  _loc7_ = _loc6_ && (_loc6_.charAt(0) == "{" || _loc6_.charAt(0) == "[");
                  _loc2_ = _loc6_ && _loc6_.charAt(0) == "<";
                  _loc3_ = _loc7_ ? JSON.parse(_loc5_.data) : _loc5_.data;
                  if(_loc7_)
                  {
                     if(_loc3_.captcha != null && _loc3_.captcha is Boolean)
                     {
                        _loc4_ = Boolean(_loc3_.captcha);
                     }
                  }
               }
               catch(e:Error)
               {
                  Logger.log("JSON parsing for Api Request ioError. Data: " + _loc5_.data);
               }
            }
            UnknownVarFromApiRequest_IHabboWebApiSession_2_1.apiError(_uri,-2,"ioError",_loc3_,_loc4_);
         }
      }
   }
}


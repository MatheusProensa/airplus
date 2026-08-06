package com.sulake.habbo.utils
{
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class HabboWebTools
   {
      public static const UnknownConstFromHabboWebTools_String_1:String = "advertisement";
      
      public static const UnknownConstFromHabboWebTools_String_2:String = "_self";
      
      public static const WINDOW_HABBO_MAIN:String = "habboMain";
      
      public static const OPEN_INTERNAL_LINK_FROM_WEB_CALLBACK:String = "openlink";
      
      public static const GOTO_ROOM_FROM_WEB_CALLBACK:String = "openroom";
      
      public static const HABBLET_AVATARS:String = "avatars";
      
      public static const HABBLET_PRIVACY:String = "privacy";
      
      public static const HABBLET_MINI_MAIL:String = "minimail";
      
      public static const HABBLET_ROOM_ENTER_AD:String = "roomenterad";
      
      public static const HABBLET_NEWS:String = "news";
      
      private static var UnknownVarFromHabboWebTools_Boolean_1:Boolean = false;
      
      private static var UnknownVarFromHabboWebTools_String_1:String;
      
      public function HabboWebTools()
      {
         super();
      }
      
      public static function set isSpaWeb(param1:Boolean) : void
      {
         UnknownVarFromHabboWebTools_Boolean_1 = param1;
      }
      
      public static function set baseUrl(param1:String) : void
      {
         UnknownVarFromHabboWebTools_String_1 = param1;
      }
      
      public static function logEventLog(param1:String) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.logEventLog",param1);
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working, failed to log event log.");
         }
      }
      
      public static function openWebPage(param1:String, param2:String = "") : void
      {
         var _loc3_:String = null;
         if(param2 == null || param2 == "")
         {
            param2 = "habboMain";
         }
         if(!param1)
         {
            return;
         }
         if(!ExternalInterface.available)
         {
            if(param1.indexOf("http") == 0)
            {
               navigateToURL(param1,param2);
            }
            else
            {
               navigateToURL(UnknownVarFromHabboWebTools_String_1 + "/" + param1,param2);
            }
         }
         else
         {
            try
            {
               _loc3_ = ExternalInterface.call("function() {return navigator.userAgent;}").toLowerCase();
               if(_loc3_.indexOf("firefox") >= 0)
               {
                  ExternalInterface.call("window.open",param1,param2);
               }
               else if(_loc3_.indexOf("msie") >= 0)
               {
                  ExternalInterface.call("function setWMWindow() {window.open(\'" + param1 + "\', \'" + param2 + "\');}");
               }
               else
               {
                  navigateToURL(param1,param2);
               }
            }
            catch(e:Error)
            {
               Logger.log("External interface not working, failed to open web page.");
            }
         }
      }
      
      public static function openPage(param1:String) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.openPage",param1);
            }
            else
            {
               if(param1.indexOf("http") == 0)
               {
                  navigateToURL(param1,"habboMain");
               }
               else
               {
                  navigateToURL(UnknownVarFromHabboWebTools_String_1 + "/" + param1,"habboMain");
               }
               Logger.log("External interface not available, openPage failed.");
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to open web page " + param1);
         }
      }
      
      public static function sendHeartBeat() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.heartBeat");
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function openWebPageAndMinimizeClient(param1:String) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               if(UnknownVarFromHabboWebTools_Boolean_1)
               {
                  openPage(param1);
                  return;
               }
            }
            if(param1.indexOf("http") == 0)
            {
               navigateToURL(param1,"habboMain");
            }
            else
            {
               navigateToURL(UnknownVarFromHabboWebTools_String_1 + "/" + param1,"habboMain");
            }
            ExternalInterface.call("FlashExternalInterface.openWebPageAndMinimizeClient",param1);
         }
         catch(e:Error)
         {
            Logger.log("Failed to open web page " + param1);
         }
      }
      
      public static function closeWebPageAndRestoreClient() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.closeWebPageAndRestoreClient");
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to close web page and restore client!");
         }
      }
      
      public static function openWebHabblet(param1:String, param2:String = null) : void
      {
         var _loc3_:String = null;
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.openHabblet",param1,param2);
            }
            else
            {
               _loc3_ = "";
               switch(param1)
               {
                  case "avatars":
                     _loc3_ = UnknownVarFromHabboWebTools_String_1 + "/settings/avatars";
                     break;
                  case "privacy":
                     _loc3_ = UnknownVarFromHabboWebTools_String_1 + "/settings/privacy";
                     break;
                  case "news":
                     _loc3_ = UnknownVarFromHabboWebTools_String_1 + "/community/category/all/1/";
                     break;
                  default:
                     Logger.log("Unknown habblet: " + param1);
               }
               if(_loc3_.length > 0)
               {
                  navigateToURL(_loc3_,"habboMain");
               }
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to open Habblet " + param1);
         }
      }
      
      public static function closeWebHabblet(param1:String, param2:String = null) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.closeHabblet",param1,param2);
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to close Habblet " + param1);
         }
      }
      
      public static function sendDisconnectToWeb(param1:int, param2:String) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.disconnect",param1,param2);
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to close send ");
         }
      }
      
      public static function showGame(param1:String) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalGameInterface.showGame",param1);
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to open game: " + e);
         }
      }
      
      public static function hideGame() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalGameInterface.hideGame");
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to hide game");
         }
      }
      
      public static function navigateToURL(param1:String, param2:String = null) : void
      {
         if(!param1 || param1.length == 0)
         {
            Logger.log("Can not navigate to empty url");
            return;
         }
         var _loc3_:URLRequest = new URLRequest(param1);
         flash.net.navigateToURL(_loc3_,param2);
      }
      
      public static function openExternalLinkWarning(param1:String) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.openExternalLink",escape(param1));
            }
            else
            {
               navigateToURL(param1,"habboMain");
               Logger.log("External interface not available. Could not request to open: " + param1);
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not request to open: " + param1);
         }
      }
      
      public static function roomVisited(param1:int) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.roomVisited",param1);
            }
            else
            {
               Logger.log("External interface not available. Could not store last room visit.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not store last room visit.");
         }
      }
      
      public static function openMinimail(param1:String) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               if(UnknownVarFromHabboWebTools_Boolean_1)
               {
                  ExternalInterface.call("FlashExternalInterface.openMinimail",param1);
               }
               else
               {
                  openWebHabblet("minimail",param1);
               }
            }
            else
            {
               openWebHabblet("minimail",param1);
               Logger.log("External interface not available. Could not open minimail.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not open minimail.");
         }
      }
      
      public static function openNews() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               if(UnknownVarFromHabboWebTools_Boolean_1)
               {
                  ExternalInterface.call("FlashExternalInterface.openNews");
               }
               else
               {
                  openWebHabblet("news");
               }
            }
            else
            {
               openWebHabblet("news");
               Logger.log("External interface not available. Could not open news.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not open news.");
         }
      }
      
      public static function closeNews() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               if(UnknownVarFromHabboWebTools_Boolean_1)
               {
                  ExternalInterface.call("FlashExternalInterface.closeNews");
               }
               else
               {
                  closeWebHabblet("news");
               }
            }
            else
            {
               closeWebHabblet("news");
               Logger.log("External interface not available. Could not close news.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not close news.");
         }
      }
      
      public static function openAvatars() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               if(UnknownVarFromHabboWebTools_Boolean_1)
               {
                  ExternalInterface.call("FlashExternalInterface.openAvatars");
               }
               else
               {
                  openWebHabblet("avatars");
               }
            }
            else
            {
               openWebHabblet("avatars");
               Logger.log("External interface not available. Could not open avatars.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not open avatars.");
         }
      }
      
      public static function openPrivacy() : void
      {
         openWebHabblet("privacy");
      }
      
      public static function openRoomEnterAd() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               if(UnknownVarFromHabboWebTools_Boolean_1)
               {
                  ExternalInterface.call("FlashExternalInterface.openRoomEnterAd");
               }
               else
               {
                  openWebHabblet("roomenterad","");
               }
            }
            else
            {
               openWebHabblet("roomenterad","");
               Logger.log("External interface not available. Could not open roomenterad.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not open roomenterad.");
         }
      }
      
      public static function updateFigure(param1:String) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               if(UnknownVarFromHabboWebTools_Boolean_1)
               {
                  ExternalInterface.call("FlashExternalInterface.updateFigure",param1);
               }
            }
            else
            {
               Logger.log("External interface not available. Could not update figure.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not update figure.");
         }
      }
      
      public static function logOut() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.logout");
            }
            else
            {
               Logger.log("External interface not available. Could not logout.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not logout.");
         }
      }
   }
}


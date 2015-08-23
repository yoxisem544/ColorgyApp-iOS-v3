//
//  UserSettingKeys.swift
//  ColorgyAPIHandler
//
//  Created by David on 2015/8/22.
//  Copyright (c) 2015年 David. All rights reserved.
//

import Foundation

struct UserSettingKey {
    static let userAccessToken = "ColorgyAccessToken"
    static let userRefreshToken = "ColorgyRefreshToken"
    static let accessTokenCreatedTime = "ColorgyCreatedTime"
    static let accessTokenExpiredTime = "ColorgyExpireTime"
    static let accessTokenscope = "ColorgyScope"
    static let isLogin = "isLogin"
    static let accessTokenTokenType = "ColorgyTokenType"
    // user info
    // something to do with me API result
    static let userName = "userName"
    static let userAccountName = "userAccountName"
    static let userOrganization = "userOrganization"
    static let userDepartment = "userDepartment"
    static let userId = "userId"
    static let userUUID = "userUUID"
    static let userAvatarUrl = "userAvatarUrl"
    static let userCoverPhotoUrl = "userCoverPhotoUrl"
    static let userType = "userType"
    // new key for unauthorized users
    static let userPossibleOrganization = "userPossibleOrganization"
    static let userPossibleDepartment = "userPossibleDepartment"
    // guide keu
    static let isGuideShownToUser = "isGuideShownToUser"
}

class UserSetting {
    
    // store at first time login
    class func storeLoginResult(#result: ColorgyLoginResult) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(result.access_token, forKey: UserSettingKey.userAccessToken)
        ud.setObject(result.created_at, forKey: UserSettingKey.accessTokenCreatedTime)
        ud.setObject(result.expires_in, forKey: UserSettingKey.accessTokenExpiredTime)
        ud.setObject(result.refresh_token, forKey: UserSettingKey.userRefreshToken)
        ud.setObject(result.scope, forKey: UserSettingKey.accessTokenscope)
        ud.setObject(result.token_type, forKey: UserSettingKey.accessTokenTokenType)
        ud.synchronize()
    }
    
    class func storeAPIMeResult(#result: ColorgyAPIMeResult) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(result._type, forKey: UserSettingKey.userType)
        ud.setObject(result.avatar_url, forKey: UserSettingKey.userAvatarUrl)
        ud.setObject(result.cover_photo_url, forKey: UserSettingKey.userCoverPhotoUrl)
        ud.setObject(result.id, forKey: UserSettingKey.userId)
        ud.setObject(result.name, forKey: UserSettingKey.userName)
        ud.setObject(result.username, forKey: UserSettingKey.userAccountName)
        ud.setObject(result.uuid, forKey: UserSettingKey.userUUID)
        ud.setObject(result.department, forKey: UserSettingKey.userDepartment)
        ud.setObject(result.organization, forKey: UserSettingKey.userOrganization)
        ud.setObject(result.possible_department_code, forKey: UserSettingKey.userPossibleDepartment)
        ud.setObject(result.possible_organization_code, forKey: UserSettingKey.userPossibleOrganization)
        ud.synchronize()
    }
    
    // TODO: logout delete settings
    // while logging out, delete setting
    // 1. logout deleting setting
    class func deleteAllUserSettings() {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.removeObjectForKey(UserSettingKey.userAccessToken)
        ud.removeObjectForKey(UserSettingKey.userRefreshToken)
        ud.removeObjectForKey(UserSettingKey.accessTokenCreatedTime)
        ud.removeObjectForKey(UserSettingKey.accessTokenExpiredTime)
        ud.removeObjectForKey(UserSettingKey.accessTokenscope)
        ud.removeObjectForKey(UserSettingKey.isLogin)
        ud.removeObjectForKey(UserSettingKey.accessTokenTokenType)
        // user info
        // something to do with me API result
        ud.removeObjectForKey(UserSettingKey.userName)
        ud.removeObjectForKey(UserSettingKey.userAccountName)
        ud.removeObjectForKey(UserSettingKey.userOrganization)
        ud.removeObjectForKey(UserSettingKey.userDepartment)
        ud.removeObjectForKey(UserSettingKey.userId)
        ud.removeObjectForKey(UserSettingKey.userUUID)
        ud.removeObjectForKey(UserSettingKey.userAvatarUrl)
        ud.removeObjectForKey(UserSettingKey.userCoverPhotoUrl)
        ud.removeObjectForKey(UserSettingKey.userType)
        // new key for unauthorized users
        ud.removeObjectForKey(UserSettingKey.userPossibleOrganization)
        ud.removeObjectForKey(UserSettingKey.userPossibleDepartment)
        // guide keu
        ud.removeObjectForKey(UserSettingKey.isGuideShownToUser)
        ud.synchronize()
    }
    // 2. refresh token expired logout
    class func refreshTokenExpiredUserSettingDeletion() {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.removeObjectForKey(UserSettingKey.userAccessToken)
        ud.removeObjectForKey(UserSettingKey.userRefreshToken)
        ud.removeObjectForKey(UserSettingKey.accessTokenCreatedTime)
        ud.removeObjectForKey(UserSettingKey.accessTokenExpiredTime)
        ud.removeObjectForKey(UserSettingKey.accessTokenscope)
        ud.removeObjectForKey(UserSettingKey.isLogin)
        ud.removeObjectForKey(UserSettingKey.accessTokenTokenType)
        // user info
        // something to do with me API result
        ud.removeObjectForKey(UserSettingKey.userName)
        ud.removeObjectForKey(UserSettingKey.userAccountName)
        ud.removeObjectForKey(UserSettingKey.userOrganization)
        ud.removeObjectForKey(UserSettingKey.userDepartment)
        ud.removeObjectForKey(UserSettingKey.userId)
        ud.removeObjectForKey(UserSettingKey.userUUID)
        ud.removeObjectForKey(UserSettingKey.userAvatarUrl)
        ud.removeObjectForKey(UserSettingKey.userCoverPhotoUrl)
        ud.removeObjectForKey(UserSettingKey.userType)
        // new key for unauthorized users
        ud.removeObjectForKey(UserSettingKey.userPossibleOrganization)
        ud.removeObjectForKey(UserSettingKey.userPossibleDepartment)
        // guide keu
//        ud.removeObjectForKey(UserSettingKey.isGuideShownToUser)
        ud.synchronize()
    }
}
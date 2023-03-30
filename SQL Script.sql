/*
{
  "realm": "master",
  "users": [
    {
      "username": "user1",
      "enabled": true,
      "totp": false,
      "emailVerified": true,
      "firstName": "user1",
      "lastName": "user1",
      "email": "user1@test.com",
      "credentials": [
        {
          "algorithm": "sha1-salted",
          "hashedSaltedValue": "9282d06b77e03989da6c0d86479ba73ac8691cfc",
          "salt": "cXdlcnR5",
          "hashIterations": 1,
          "type": "password"
        }
      ],
      "disableableCredentialTypes": [],
      "requiredActions": [],
      "realmRoles": [
        "offline_access",
        "uma_authorization"
      ],
      "clientRoles": {
        "account": [
          "manage-account",
          "view-profile"
        ]
      }
    }
  ]
}

--P@ssw0rd1!


*/


-- Email Addresses must be UNIQUE!
-- Using TOP prevents the lead function from working!
-- dummy10346701testapi5@sap.com
-- 123456789
set nocount on

select '[{
    "realm": "swapi",
    "users": ['
union all
select
+ coalesce('     {"username":"' + cast(replace(replace(replace(replace(replace(u.[UserName], char(9), ''), char(10), ''), char(13), ''), '\', '\\'), '"', '\"') as varchar(255)) + '", ','')  + char(13) +
+          '      "enabled": true,' + char(13) +
+          '      "totp": false,' + char(13) +
+          '      "emailVerified": false,' + char(13) +
+ coalesce('      "firstName":"' + cast(replace(replace(replace(replace(replace(u.[FirstName], char(9), ''), char(10), ''), char(13), ''), '\', '\\'), '"', '\"') as varchar(255)) + '", ','') + char(13) +
+ coalesce('      "lastName":"' + cast(replace(replace(replace(replace(replace(u.[LastName], char(9), ''), char(10), ''), char(13), ''), '\', '\\'), '"', '\"') as varchar(255)) + '", ','') + char(13) +
--+ coalesce('      "email":"' + cast(replace(replace(replace(replace(replace(u.[EMail], char(9), ''), char(10), ''), char(13), ''), '\', '\\'), '"', '\"') as varchar(255)) + '", ','') + char(13) +
--+ coalesce('      "email":"' + cast(replace(replace(replace(replace(replace('george.parker@lytx.com', char(9), ''), char(10), ''), char(13), ''), '\', '\\'), '"', '\"') as varchar(255)) + '", ','') + char(13) +
           '      "attributes": ' + char(13) +
+          '            {' + char(13) +
+		   '            "locale": ["de"],' + char(13)
+		   '            "id": ["' + coalesce(cast(replace(replace(replace(u.[id], char(9), ''), char(10), ''), char(13), '') as varchar(255)) + '"], ','') + char(13)
+		   '            "co_id": [' + coalesce(cast(replace(replace(replace(uc.[CompanyId], char(9), ''), char(10), ''), char(13), '') as varchar(255)) + '], ','') + char(13)
+		   '            "rootgroupid": ["' + coalesce(cast(replace(replace(replace(c.[RootGroupId], char(9), ''), char(10), ''), char(13), '') as varchar(255)) + '"], ','') + char(13)
+		   '            "ismultiplecompanyuser": ["' + coalesce(cast(replace(replace(replace(u.[IsMultipleCompanyUser], char(9), ''), char(10), ''), char(13), '') as varchar(255)) + '"]','') + char(13)
+  	       '            },' + char(13) +

--+ coalesce('"IsMultipleCompanyUser":' + cast(replace(replace(replace(u.[IsMultipleCompanyUser], char(9), ''), char(10), ''), char(13), '') as varchar(255)) + ', ','')
--+ coalesce('"UserType":' + cast(replace(replace(replace(u.[UserTypeId], char(9), ''), char(10), ''), char(13), '') as varchar(255)) + ', ','')
--+ coalesce('"Status":' + cast(replace(replace(replace(ugp.[UserStatusId], char(9), ''), char(10), ''), char(13), '') as varchar(255)) + '', '')

--+          '      "credentials": [{"type": "password","algorithm": "bcrypt","hashedSaltedValue": "$2y$10$xxxxx"}],' + char(13) +




+          '      "credentials": ' + char(13) +
+          '      [' + char(13) +
+          '         {' + char(13) +
+          '           "credentialData": "{\"hashIterations\": 27500,\"algorithm\": \"pbkdf2-sha256\"}",' + char(13) +
+          '           "secretData": "{\"salt\": \"CbsZxep7MExFNDi2lFvLxw==\",\"value\": \"X3uAg4ePcjdgWpvzKY1etQ==\"}",' + char(13) +
+          '           "type": "password"' + char(13) +
+          '         }' + char(13) +
+          '      ],' + char(13) +


+          '      "realmRoles": ' + char(13) +
+          '      [' + char(13) +
+          '           "uma_authorization"' + char(13) +
+          '      ],' + char(13) +


+          '      "disableableCredentialTypes": [],' + char(13) +
+          '      "requiredActions": ["UPDATE_PASSWORD"],' + char(13) +
+          '      "createdTimestamp": ' + CONVERT(varchar(50), 1000 * CONVERT(BIGINT,DATEDIFF(second, '1970-01-01', sysutcdatetime()))) + ',' + char(13) +
+          '      "notBefore": 0}'
+ case when lead(u.[id],1,null) over (order by u.[id]) is not null then ',' else ']' end
from [hub].[Users] u
       inner join [hub].[UserCompany] uc 
              on u.[Id] = uc.[UserId]
          inner join [hub].[Companies] c
                       on uc.[CompanyId] = c.[Id]
          inner join [hs].[UserGroupProfiles] ugp
                       on u.[Id] = ugp.[UserId] 
                                  and c.[RootGroupId] = ugp.[GroupId]
where u.IsMultipleCompanyUser = 0
and c.id = 1024
and u.UserName like 'dummy103467%'
and u.UserName like '%TESTAPI%'
--where ugp.StackId = @stackID
--and u.UserName not like '%['']%'
--and u.UserName not like '%["]%'
--and u.UserName not like '%[\]%'
--and u.Email not like '%['']%'
--and u.Email not like '%["]%'
--and u.Email not like '%[\]%'
--and u.LastName not like  '%['']%'
--and u.LastName not like '%["]%'
--and u.LastName not like '%[\]%'
--and u.FirstName not like '%['']%'
--and u.FirstName not like '%["]%'
--and u.FirstName not like '%[\]%'
union all
select '}]';

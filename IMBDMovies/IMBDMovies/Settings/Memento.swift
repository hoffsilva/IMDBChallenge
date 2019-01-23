//
//  ConstantsUtil.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

struct Memento {
    static func movieTrailersURL(from movieID: Int) -> String {
        return UrlsEnum.apiMainUrl.getValue() +
            EndpointsEnum.getMovieTrailer.getValue().replacingOccurrences(of: "<MOVIE-ID>", with: String(movieID), options: .literal, range: nil) +
            ParametersEnum.apiKeyParam.getValue() +
            MementoEnum.apiKeyParamValue.getValue()
    }
    
    static func genresListURL() -> String {
        return UrlsEnum.apiMainUrl.getValue() +
            EndpointsEnum.getGenresList.getValue() +
            ParametersEnum.apiKeyParam.getValue() +
            MementoEnum.apiKeyParamValue.getValue() +
            ParametersEnum.languageParam.getValue() +
            MementoEnum.languageParamValue.getValue()
    }
    
    static func upcomingMoviesURL() -> String {
        return UrlsEnum.apiMainUrl.getValue() +
            EndpointsEnum.getUpcomingMovies.getValue() +
            ParametersEnum.apiKeyParam.getValue() +
            MementoEnum.apiKeyParamValue.getValue() +
            ParametersEnum.languageParam.getValue() +
            MementoEnum.languageParamValue.getValue() +
            ParametersEnum.pageParam.getValue() +
            MementoEnum.currentPageNumberValue.getValue()
    }
    
    static func searchMoviesURL() -> String {
        return UrlsEnum.apiMainUrl.getValue() +
            EndpointsEnum.getSearchMovie.getValue() +
            ParametersEnum.apiKeyParam.getValue() +
            MementoEnum.apiKeyParamValue.getValue() +
            ParametersEnum.languageParam.getValue() +
            MementoEnum.languageParamValue.getValue() +
            ParametersEnum.pageParam.getValue() +
            MementoEnum.currentPageNumberValue.getValue() +
            ParametersEnum.queryParam.getValue() +
            MementoEnum.queryValue.getValue() +
            ParametersEnum.includeAdultParam.getValue() +
            MementoEnum.includeAdultValue.getValue()
    }
    
    static func primaryTranslationsURL() -> String {
        return UrlsEnum.apiMainUrl.getValue() +
            EndpointsEnum.getTranslates.getValue() +
            ParametersEnum.apiKeyParam.getValue() +
            MementoEnum.apiKeyParamValue.getValue()
    }
    
    static func countriesURL() -> String {
        return UrlsEnum.apiMainUrl.getValue() +
            EndpointsEnum.getCountries.getValue() +
            ParametersEnum.apiKeyParam.getValue() +
            MementoEnum.apiKeyParamValue.getValue()
    }
    
    static func languagesURL() -> String {
        return UrlsEnum.apiMainUrl.getValue() +
            EndpointsEnum.getLanguages.getValue() +
            ParametersEnum.apiKeyParam.getValue() +
            MementoEnum.apiKeyParamValue.getValue()
    }
}
